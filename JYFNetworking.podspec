
Pod::Spec.new do |s|

  s.name         = "JYFNetworking"
  s.version      = "0.0.24"
  s.summary      = "Have no summary JYFNetworking."

  s.description  = <<-DESC
                   A Main Foundation Component for Other Kit
                   DESC

  s.homepage     = "https://github.com/554994782/JYFNetWorking.git"

  s.license      = "MIT"

  s.author       = { "jiangyunfeng" => "554994782@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/554994782/JYFNetWorking.git", :branch => "develop" }

  s.source_files  = "JYFNetworking"

s.subspec "API" do |ss|
ss.source_files = "JYFNetworking/API/*.{h,swift,c,m}"
end

s.subspec "Common" do |ss|
ss.source_files = "JYFNetworking/Config/*.{h,swift,c,m}"
end

s.subspec "Tool" do |ss|
ss.source_files = "JYFNetworking/Tool/*.{h,swift,c,m}"
ss.public_header_files = "JYFNetworking/Tool/*.h"
ss.vendored_frameworks = "JYFNetworking/Tool/AMapFoundationKit.framework","ESNetworking/Tool/AMapLocationKit.framework"
ss.ios.frameworks = "CoreMotion", "CFNetwork", "SystemConfiguration", "CoreTelephony", "QuartzCore", "CoreText", "CoreGraphics"
ss.ios.libraries = "z", "c++"
end

  s.public_header_files = "JYFNetworking/**/*.h"

s.dependency 'JYFBasic'
s.dependency 'Gloss'
s.dependency 'Moya/RxSwift'
s.dependency 'RealmSwift'
s.dependency 'CryptoSwift'
end
