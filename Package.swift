// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "NSMUIKit",
  platforms: [
    .iOS(.v11)
  ],
  products: [
    .library(name: "NSMUIKit", targets: ["NSMUIKit"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMinor(from: "5.0.1")),
    .package(url: "https://github.com/nesium/Flex.git", .upToNextMajor(from: "0.9.0"))
  ],
  targets: [
    .target(name: "NSMUIKit", dependencies: ["RxSwift", "Flex"])
  ]
)
