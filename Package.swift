// swift-tools-version: 5.9
// MediaNetAdSDK — version 1.0.0
//
// Wrapper-only distribution manifest (repo split, >= 0.4.8):
//   - OMSDK_Medianet comes from the OMSDK-Medianet-dist package — never declare
//     it as a binaryTarget here (duplicate-target error for any graph that also
//     pulls OMSDK-Medianet-dist, e.g. FoxSDK / MediaNetRendererAdSDK).
//   - Renderer products live on media-net/ios-packages (>= 0.5.0).

import PackageDescription

let package = Package(
    name: "MediaNetAdSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MediaNetAdSDK",
            targets: [
                "MediaNetAdSDK",
                "MNPrebidMobile",
                "MediaNetAdSDKGoogleAdsLink"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads",
            from: "12.3.0"
        ),
        // Shared dynamic OMID build — single owner of the OMSDK_Medianet target.
        // `from:` (not `exact:`) so a future OMSDK patch does not deadlock
        // graphs where another package carries a different OMSDK floor.
        .package(
            url: "https://github.com/media-net/OMSDK-Medianet-dist",
            from: "1.5.5"
        )
    ],
    targets: [
        .binaryTarget(
            name: "MediaNetAdSDK",
            url: "https://github.com/media-net/MediaNetAdSDK-dist/releases/download/v1.0.0/MediaNetAdSDK.xcframework.zip",
            checksum: "0111602c0d970774d0f792aa86082b7774c369a8a8200ba66cf7e769d5884f85"
        ),
        // Namespaced Prebid Mobile fork the wrapper links. Hosted here because a
        // binary target cannot bundle another binary's dependencies.
        .binaryTarget(
            name: "MNPrebidMobile",
            url: "https://github.com/media-net/MediaNetAdSDK-dist/releases/download/v1.0.0/MNPrebidMobile.xcframework.zip",
            checksum: "4debce25e8a74d815ac84dce67628be75cea6b6f3a6b15e21b546a623648e164"
        ),
        // Carries the GoogleMobileAds + OMSDK_Medianet package edges into the
        // product link graph (binary targets cannot declare dependencies).
        .target(
            name: "MediaNetAdSDKGoogleAdsLink",
            dependencies: [
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
                .product(name: "OMSDK_Medianet", package: "omsdk-medianet-dist")
            ],
            path: "Sources/MediaNetAdSDKGoogleAdsLink"
        )
    ]
)
