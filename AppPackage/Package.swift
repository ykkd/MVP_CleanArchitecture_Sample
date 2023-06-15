// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: Settings

let debugOtherSwiftFlags = [
    "-Xfrontend", "-warn-long-expression-type-checking=500",
    "-Xfrontend", "-warn-long-function-bodies=500",
    "-strict-concurrency=targeted",
    "-enable-actor-data-race-checks",
]

let debugSwiftSettings: [PackageDescription.SwiftSetting] = [
    .unsafeFlags(debugOtherSwiftFlags, .when(configuration: .debug)),
    .enableUpcomingFeature("ConciseMagicFile", .when(configuration: .debug)), // SE-0274
    .enableUpcomingFeature("ForwardTrailingClosures", .when(configuration: .debug)), // SE-0286
    .enableUpcomingFeature("ExistentialAny", .when(configuration: .debug)), // SE-0335
    .enableUpcomingFeature("BaseSlashRegexLiterals", .when(configuration: .debug)), // SE-0354
]

// MARK: Targets(System Architecture)

enum SystemArchitectureTargets {

    static let allTargets: [Target] = [
        entity,
        infrastructure,
        infrastructureInterface,
        application,
        applicationInterface,
    ] + PresentationTargets.allTargets

    static let entity = Target.target(
        name: "Entity",
        dependencies: [
            .target(name: SupportTargets.sharedExtension.name),
        ],
        path: "./Sources/Layer/Entity",
        swiftSettings: debugSwiftSettings
    )

    static let infrastructureInterface = Target.target(
        name: "InfrastructureInterface",
        dependencies: [
            .target(name: SystemArchitectureTargets.entity.name),
            .target(name: SupportTargets.apiWrapper.name),
        ],
        path: "./Sources/Layer/InfrastructureInterface",
        swiftSettings: debugSwiftSettings
    )

    static let infrastructure = Target.target(
        name: "Infrastructure",
        dependencies: [
            .target(name: SystemArchitectureTargets.entity.name),
            .target(name: SystemArchitectureTargets.infrastructureInterface.name),
            .target(name: SupportTargets.apiWrapper.name),
            .target(name: SupportTargets.dependency.name),
        ],
        path: "./Sources/Layer/Infrastructure",
        swiftSettings: debugSwiftSettings
    )

    static let applicationInterface = Target.target(
        name: "ApplicationInterface",
        dependencies: [
            .target(name: SystemArchitectureTargets.entity.name),
            .target(name: SystemArchitectureTargets.infrastructureInterface.name),
        ],
        path: "./Sources/Layer/ApplicationInterface",
        swiftSettings: debugSwiftSettings
    )

    static let application = Target.target(
        name: "Application",
        dependencies: [
            .target(name: SystemArchitectureTargets.applicationInterface.name),
            .target(name: SupportTargets.infrastructureDependencies.name),
        ],
        path: "./Sources/Layer/Application",
        swiftSettings: debugSwiftSettings
    )

    enum PresentationTargets: CaseIterable {
        case sharedTarget
        case extensionTarget
        case pokemonListTarget

        static let allTargets: [Target] = Self.allCases.map(\.value)

        var value: Target {
            switch self {
            case .sharedTarget:
                return Target.target(
                    name: "SharedPresentation",
                    dependencies: [
                        .target(name: SystemArchitectureTargets.applicationInterface.name),
                        .product(name: "Nuke", package: "Nuke"),
                    ],
                    path: "./Sources/Layer/Presentation/Shared",
                    swiftSettings: debugSwiftSettings
                )
            case .extensionTarget:
                return Target.target(
                    name: "PresentationExtension",
                    dependencies: [],
                    path: "./Sources/Layer/Presentation/Extension",
                    swiftSettings: debugSwiftSettings
                )
            case .pokemonListTarget:
                return Target.target(
                    name: "PokemonListScreen",
                    dependencies: [
                        .target(name: SupportTargets.applicationDependencies.name),
                        .target(name: PresentationTargets.extensionTarget.value.name),
                        .target(name: PresentationTargets.sharedTarget.value.name),
                    ],
                    path: "./Sources/Layer/Presentation/PokemonListScreen",
                    swiftSettings: debugSwiftSettings
                )
            }
        }
    }
}

enum SupportTargets {

    static let allTargets: [Target] = [
        apiWrapper,
        dependency,
        sharedExtension,
        infrastructureDependencies,
        applicationDependencies,
    ]

    static let apiWrapper = Target.target(
        name: "ApiWrapper",
        dependencies: [],
        path: "./Sources/Support/ApiWrapper",
        swiftSettings: debugSwiftSettings
    )

    static let dependency = Target.target(
        name: "Dependency",
        dependencies: [],
        path: "./Sources/Support/Dependency/Core",
        swiftSettings: debugSwiftSettings
    )

    static let infrastructureDependencies = Target.target(
        name: "InfrastructureDependencies",
        dependencies: [
            .target(name: SupportTargets.dependency.name),
            .target(name: SystemArchitectureTargets.infrastructure.name),
            .target(name: SystemArchitectureTargets.infrastructureInterface.name),
        ],
        path: "./Sources/Support/Dependency/Infrastructure",
        swiftSettings: debugSwiftSettings
    )

    static let applicationDependencies = Target.target(
        name: "ApplicationDependencies",
        dependencies: [
            .target(name: SupportTargets.dependency.name),
            .target(name: SystemArchitectureTargets.application.name),
            .target(name: SystemArchitectureTargets.applicationInterface.name),
        ],
        path: "./Sources/Support/Dependency/Application",
        swiftSettings: debugSwiftSettings
    )

    static let sharedExtension = Target.target(
        name: "SharedExtension",
        dependencies: [],
        path: "./Sources/Support/SharedExtension",
        swiftSettings: debugSwiftSettings
    )
}

// MARK: Dependency

enum PackageDependencies {
    static let allDependencies: [Package.Dependency] = [
        logger,
        nuke,
    ]

    static let logger: Package.Dependency = .package(
        url: "https://github.com/apple/swift-log.git",
        from: "1.0.0"
    )

    static let nuke: Package.Dependency = .package(
        url: "https://github.com/kean/Nuke.git",
        from: "12.0.0"
    )
}

let package = Package(
    name: "AppPackage",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PokemonListScreen",
            targets: [
                SystemArchitectureTargets.PresentationTargets.pokemonListTarget.value.name
            ]
        )
    ],
    dependencies: PackageDependencies.allDependencies,
    targets: SystemArchitectureTargets.allTargets + SupportTargets.allTargets
)
