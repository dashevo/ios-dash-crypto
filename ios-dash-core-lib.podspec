#
# Be sure to run `pod lib lint ios-dash-core-lib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ios-dash-core-lib'
  s.version          = '0.1.0'
  s.summary          = 'Dash iOS Core Library'

  s.description      = <<-DESC
Contains BigInt, X11 implementation, secp256k1 and BLS signatures dependencies, DSKey implementation and blockchain-related categories on Foundation objects
                       DESC

  s.homepage         = 'https://github.com/Andrew Podkovyrin/ios-dash-core-lib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew Podkovyrin' => 'podkovyrin@gmail.com' }
  s.source           = { :git => 'https://github.com/Andrew Podkovyrin/ios-dash-core-lib.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dahspay'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ios-dash-core-lib/**/*.{h,m,mm}'
  s.public_header_files = 'ios-dash-core-lib/**/*.h'
  s.private_header_files = 'ios-dash-core-lib/crypto/x11/*.h'
  
  s.framework = 'Foundation'
  s.compiler_flags = '-Wno-comma'
  s.dependency 'secp256k1_dash', '0.1.2'
  s.dependency 'bls-signatures-pod', '0.2.9'

end
