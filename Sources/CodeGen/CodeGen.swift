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
  public init() {}

  public func gen(_ topLevelDecl: TopLevelDeclaration, to file: String) {
    for stmt in topLevelDecl.statements {
      gen(stmt)
    }

    let j = """
    .class public Main
    .super java/lang/Object

    .method public static main : ([Ljava/lang/String;)V
        .limit stack 10
        .limit locals 10

        getstatic java/lang/System out Ljava/io/PrintStream;
        ldc "hello world"
        invokevirtual java/io/PrintStream println (Ljava/lang/Object;)V
        return
    .end method
    """

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
  }

  public func gen(_ funcCallExpr: FunctionCallExpression) {
  }
}
