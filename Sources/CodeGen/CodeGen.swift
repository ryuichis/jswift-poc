/*
   Copyright 2017 Ryuichi Saito, LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import Foundation

import AST

public class CodeGen {
  var j: String

  public init() {
    j = ""
  }

  public func gen(_ topLevelDecl: TopLevelDeclaration, to file: String) {
    j = """
    .class public Main
    .super java/lang/Object


    """

    for stmt in topLevelDecl.statements {
      gen(stmt)
    }

    try! j.write(toFile: file, atomically: true, encoding: .utf8)
  }

  public func gen(_ stmt: Statement) {
    switch stmt {
    case let funcDecl as FunctionDeclaration:
      gen(funcDecl)
    case let funcCallExpr as FunctionCallExpression:
      gen(funcCallExpr)
    default:
      break
    }
  }

  public func gen(_ funcDecl: FunctionDeclaration) {
    guard funcDecl.name == "main" else { return }

    j += """
    .method public static main : ([Ljava/lang/String;)V
      .limit stack 10
      .limit locals 10

    """

    let stmts = funcDecl.body?.statements ?? []
    for stmt in stmts {
      gen(stmt)
    }

    j += """
      return
    .end method
    """
  }

  public func gen(_ funcCallExpr: FunctionCallExpression) {
    guard funcCallExpr.postfixExpression.textDescription == "print" else { return }
    guard let firstArg = funcCallExpr.argumentClause?.first,
      case .expression(let firstExpr) = firstArg,
      let literalExpr = firstExpr as? LiteralExpression,
      case .staticString(let str, _) = literalExpr.kind
    else {
      return
    }

    j += """

      getstatic java/lang/System out Ljava/io/PrintStream;
      ldc "\(str)"
      invokevirtual java/io/PrintStream println (Ljava/lang/Object;)V

    """
  }
}
