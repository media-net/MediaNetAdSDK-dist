Pod::Spec.new do |s|
  s.name             = 'MediaNetAdSDK'
  s.version          = '1.0.2'
  s.summary          = 'MediaNetAdSDK — Media.net advertising SDK for iOS.'
  s.homepage         = 'https://github.com/media-net/MediaNetAdSDK-dist'
  s.license          = { :type => 'CUSTOM' }
  s.author           = { 'Media.net' => 'sdk-dev@media.net' }
  s.platform         = :ios, '13.0'
  s.source           = { :http => 'https://github.com/media-net/MediaNetAdSDK-dist/releases/download/v1.0.2/MediaNetAdSDK.xcframework.zip' }
  s.vendored_frameworks = 'MediaNetAdSDK.xcframework'
  s.static_framework = true
  # Static framework: the flat PrivacyInfo.xcprivacy is not copied into the host
  # app, so it ships as a CocoaPods resource bundle (release script stages
  # MediaNetAdSDKResources/ alongside the xcframework in the zip).
  s.resource_bundles = { 'MediaNetAdSDKResources' => ['MediaNetAdSDKResources/*'] }
  s.dependency 'MNPrebidMobile', '1.0.2'
  s.dependency 'Google-Mobile-Ads-SDK', '~> 12.3.0'
  s.dependency 'OMSDK_Medianet', '1.5.5'
end
