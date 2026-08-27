// swift-tools-version: 5.9
// MediaNetAdSDK — version 0.4.9
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
            url: "https://github.com/media-net/MediaNetAdSDK-dist/releases/download/v0.4.9/MediaNetAdSDK.xcframework.zip",
            checksum: "1a544abcbb0c3d7c5f0109d244e31c279fa48c0769e6b785cbca06c2c7721fdf"
        ),
        // Namespaced Prebid Mobile fork the wrapper links. Hosted here because a
        // binary target cannot bundle another binary's dependencies.
        .binaryTarget(
            name: "MNPrebidMobile",
            url: "https://github.com/media-net/MediaNetAdSDK-dist/releases/download/v0.4.9/MNPrebidMobile.xcframework.zip",
            checksum: "9693224d894980200a81fd07c411746d3c063bc87909d8bc21dc5528acf51be5"
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
