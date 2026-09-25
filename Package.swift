// swift-tools-version: 5.9
// MediaNetAdSDK — version 1.0.1
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
            url: "https://github.com/media-net/MediaNetAdSDK-dist/releases/download/v1.0.1/MediaNetAdSDK.xcframework.zip",
            checksum: "7bb8861c03e999e10c71045c86bd5aba9e32b740ca80429e21557a9f218a1ef4"
        ),
        // Namespaced Prebid Mobile fork the wrapper links. Hosted here because a
        // binary target cannot bundle another binary's dependencies.
        .binaryTarget(
            name: "MNPrebidMobile",
            url: "https://github.com/media-net/MediaNetAdSDK-dist/releases/download/v1.0.1/MNPrebidMobile.xcframework.zip",
            checksum: "87e3c68d7b1329a584810b130fe8075eaa0868912f287cb151ca0d9fe082de70"
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
