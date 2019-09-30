// swift-tools-version:5.1

import PackageDescription
let package = Package(
    name: "RxSwiftly",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "RxSwiftly",
            targets: ["RxSwiftly"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(
            name: "RxSwiftly",
            dependencies: [ "RxSwift", "RxCocoa" ],
            path: "Source")
    ],
    swiftLanguageVersions: [ .v4, .v5 ]
)
