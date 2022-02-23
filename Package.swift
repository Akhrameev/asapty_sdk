import ProjectDescription
import ProjectDescriptionHelpers

let sdk = Target(name: "ASAPTY_SDK",
                 platform: .iOS,
                 product: .framework,
                 productName: "ASAPTY_SDK",
                 bundleId: "com.asapty.sdk",
                 infoPlist: .default,
                 sources: .paths([
                     "Sources/**/*",
                 ]),
                 dependencies: [
                    .sdk(name: "AdServices.framework", status: .optional)
                 ],
                 environment: [:])
let example = Target(name: "ASAPTY Example",
                     platform: .iOS,
                     product: .app,
                     productName: "ASAPTY",
                     bundleId: "com.asapty.sdk.example",
                     infoPlist: .default,
                     sources: .paths([
                         "Example/Sources/**/*",
                     ]),
                     dependencies: [
                        .target(name: "ASAPTY_SDK")
                     ],
                     environment: [:])

let p = Project(name: "ASAPTY iOS SDK",
                targets: [sdk, example],
                additionalFiles: ["README.md", "LICENSE"])


// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ASAPTY_SDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "ASAPTY_SDK", targets: ["ASAPTY_SDK"])
    ],
    targets: [
        .target(
            name: "ASAPTY_SDK",
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
