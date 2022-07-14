#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_kgo_vnpay.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_kgo_vnpay'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin project to connect with vnpay'
  s.description      = <<-DESC
  A Flutter plugin project to connect with vnpay.
                       DESC
  s.homepage         = 'http://kgo.life'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Kgo' => 'duongnh@kaopiz.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  
  s.preserve_paths = 'Frameworks/CallAppSDK.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework CallAppSDK' }
  s.vendored_frameworks = 'Frameworks/CallAppSDK.framework'
  s.pod_target_xcconfig = { 'ONLY_ACTIVE_ARCH' => 'YES' }
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' }
end
