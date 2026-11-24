// swift-tools-version: 6.4

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .strictMemorySafety(),
]

let package = Package(
    name: "harbor-protos",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .library(name: "AuthProtos", targets: ["AuthProtos"]),
        .library(name: "UsersProtos", targets: ["UsersProtos"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.41.0", traits: []),
        .package(url: "https://github.com/grpc/grpc-swift-2.git", from: "2.4.4"),
        .package(url: "https://github.com/grpc/grpc-swift-protobuf.git", from: "2.5.0"),
    ],
    targets: [
        .target(
            name: "AuthProtos",
            dependencies: [
                .product(name: "GRPCCore", package: "grpc-swift-2"),
                .product(name: "GRPCProtobuf", package: "grpc-swift-protobuf"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            swiftSettings: swiftSettings,
            plugins: [
                .plugin(name: "GRPCProtobufGenerator", package: "grpc-swift-protobuf")
            ]
        ),
        .target(
            name: "UsersProtos",
            dependencies: [
                .product(name: "GRPCCore", package: "grpc-swift-2"),
                .product(name: "GRPCProtobuf", package: "grpc-swift-protobuf"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            swiftSettings: swiftSettings,
            plugins: [
                .plugin(name: "GRPCProtobufGenerator", package: "grpc-swift-protobuf")
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
