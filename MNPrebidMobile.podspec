Pod::Spec.new do |s|
  s.name             = 'MNPrebidMobile'
  s.version          = '1.1.0'
  s.summary          = 'Namespaced Prebid Mobile fork used by MediaNetAdSDK.'
  s.homepage         = 'https://github.com/media-net/MediaNetAdSDK-dist'
  s.license          = { :type => 'Commercial' }
  s.author           = { 'Media.net' => 'mobile@media.net' }
  s.platform         = :ios, '13.0'
  s.source           = { :http => 'https://github.com/media-net/MediaNetAdSDK-dist/releases/download/v1.1.0/MNPrebidMobile.xcframework.zip' }
  s.vendored_frameworks = 'MNPrebidMobile.xcframework'
  s.frameworks       = 'WebKit', 'SafariServices'
  s.weak_frameworks  = 'AdSupport', 'AppTrackingTransparency', 'CoreLocation'
end
