// swift-tools-version:5.1
import PackageDescription

let crossPlatHeaders = [CSetting.headerSearchPath("src"),
                        CSetting.headerSearchPath("src/configuration"),
                        CSetting.headerSearchPath("src/configuration/webview"),
                        CSetting.headerSearchPath("src/logger"),
                        CSetting.headerSearchPath("src/cache"),
                        CSetting.headerSearchPath("src/cache/token"),
                        CSetting.headerSearchPath("src/cache/token/Matchers"),
                        CSetting.headerSearchPath("src/cache/accessor"),
                        CSetting.headerSearchPath("src/cache/key"),
                        CSetting.headerSearchPath("src/cache/serializers"),
                        CSetting.headerSearchPath("src/cache/metadata"),
                        CSetting.headerSearchPath("src/cache/metadata/accountMetadata"),
                        CSetting.headerSearchPath("src/broker_operation"),
                        CSetting.headerSearchPath("src/broker_operation/response"),
                        CSetting.headerSearchPath("src/broker_operation/request"),
                        CSetting.headerSearchPath("src/broker_operation/request/interactive_token_request"),
                        CSetting.headerSearchPath("src/broker_operation/request/account_request"),
                        CSetting.headerSearchPath("src/broker_operation/request/token_request"),
                        CSetting.headerSearchPath("src/broker_operation/request/silent_token_request"),
                        CSetting.headerSearchPath("src/util"),
                        CSetting.headerSearchPath("src/network"),
                        CSetting.headerSearchPath("src/network/response_serializer"),
                        CSetting.headerSearchPath("src/network/response_serializer/preprocessor"),
                        CSetting.headerSearchPath("src/network/error_handler"),
                        CSetting.headerSearchPath("src/network/request_configurator"),
                        CSetting.headerSearchPath("src/network/request_telemetry"),
                        CSetting.headerSearchPath("src/network/session_delegate"),
                        CSetting.headerSearchPath("src/network/request"),
                        CSetting.headerSearchPath("src/network/request_serializer"),
                        CSetting.headerSearchPath("src/webview"),
                        CSetting.headerSearchPath("src/webview/background"),
                        CSetting.headerSearchPath("src/webview/embeddedWebview"),
                        CSetting.headerSearchPath("src/webview/embeddedWebview/ui"),
                        CSetting.headerSearchPath("src/webview/embeddedWebview/challangeHandlers"),
                        CSetting.headerSearchPath("src/webview/response"),
                        CSetting.headerSearchPath("src/webview/pkce"),
                        CSetting.headerSearchPath("src/webview/systemWebview"),
                        CSetting.headerSearchPath("src/webview/systemWebview/session"),
                        CSetting.headerSearchPath("src/oauth2"),
                        CSetting.headerSearchPath("src/oauth2/token"),
                        CSetting.headerSearchPath("src/oauth2/token/protocols"),
                        CSetting.headerSearchPath("src/oauth2/aad_v2"),
                        CSetting.headerSearchPath("src/oauth2/appmetadata"),
                        CSetting.headerSearchPath("src/oauth2/b2c"),
                        CSetting.headerSearchPath("src/oauth2/aad_v1"),
                        CSetting.headerSearchPath("src/oauth2/aad_base"),
                        CSetting.headerSearchPath("src/oauth2/account"),
                        CSetting.headerSearchPath("src/requests"),
                        CSetting.headerSearchPath("src/requests/result"),
                        CSetting.headerSearchPath("src/requests/broker"),
                        CSetting.headerSearchPath("src/requests/sdk"),
                        CSetting.headerSearchPath("src/requests/sdk/msal"),
                        CSetting.headerSearchPath("src/requests/sdk/adal"),
                        CSetting.headerSearchPath("src/parameters"),
                        CSetting.headerSearchPath("src/intune"),
                        CSetting.headerSearchPath("src/intune/data_source"),
                        CSetting.headerSearchPath("src/telemetry"),
                        CSetting.headerSearchPath("src/controllers"),
                        CSetting.headerSearchPath("src/controllers/broker"),
                        CSetting.headerSearchPath("src/validation"),
                        CSetting.headerSearchPath("src/claims"),
                        CSetting.headerSearchPath("src/workplacejoin"),
                        CSetting.headerSearchPath("src/util/ios", .when(platforms: [.iOS])),
                        CSetting.headerSearchPath("src/workplacejoin/ios", .when(platforms: [.iOS])),
                        CSetting.headerSearchPath("src/controllers/broker/ios", .when(platforms: [.iOS])),
                        CSetting.headerSearchPath("src/webview/systemWebview/ios", .when(platforms: [.iOS])),
                        CSetting.headerSearchPath("src/webview/embeddedWebview/challangeHandlers/ios", .when(platforms: [.iOS])),
                        CSetting.headerSearchPath("src/webview/background/ios", .when(platforms: [.iOS])),
                        CSetting.headerSearchPath("src/webview/embeddedWebview/ui/ios", .when(platforms: [.iOS])),
                        CSetting.headerSearchPath("src/cache/mac", .when(platforms: [.macOS])),
                        CSetting.headerSearchPath("src/util/mac", .when(platforms: [.macOS])),
                        CSetting.headerSearchPath("src/webview/embeddedWebview/challangeHandlers/mac", .when(platforms: [.macOS])),
                        CSetting.headerSearchPath("src/webview/embeddedWebview/ui/mac", .when(platforms: [.macOS])),
                        CSetting.headerSearchPath("src/workplacejoin/mac", .when(platforms: [.macOS])),
                        CSetting.define("ENABLE_SPM")]

let iOSExcludedFolders = [      "src/cache/mac",
                                "src/util/mac",
                                "src/webview/embeddedWebview/challangeHandlers/mac",
                                "src/webview/embeddedWebview/ui/mac",
                                "src/workplacejoin/mac"]

let macOSExcludedFolders = [    "src/util/ios",
                                "src/workplacejoin/ios",
                                "src/controllers/broker/ios",
                                "src/webview/systemWebview/ios",
                                "src/webview/embeddedWebview/challangeHandlers/ios",
                                "src/webview/background/ios",
                                "src/webview/embeddedWebview/ui/ios"]

#if os(iOS)

#else

#endif

let package = Package(
    name: "IdentityCore",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "IdentityCore", targets: ["IdentityCore"])
    ],
    targets: [
        .target(
            name: "IdentityCore",
            path: "IdentityCore",
            sources: ["src"],
            publicHeadersPath: "src",
            cSettings: crossPlatHeaders
        )
    ]
)
