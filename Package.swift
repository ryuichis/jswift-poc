import PackageDescription

let package = Package(name: "jswift",
  targets: [
    Target(
      name: "CodeGen"
    ),
    Target(
      name: "jswift",
      dependencies: [
        "CodeGen",
      ]
    ),
  ],
  dependencies: [
    .Package(url: "https://github.com/yanagiba/swift-ast.git", majorVersion: 0),
  ]
)
