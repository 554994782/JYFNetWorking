
Pod::Spec.new do |s|

  s.name         = "ESNetworking"
  s.version      = "0.0.24"
  s.summary      = "Have no summary ESNetworking."

  s.description  = <<-DESC
                   A Main Foundation Component for Other Kit
                   DESC

  s.homepage     = "https://gitlab-dev.shejijia.com/mobile-sjj-plt/component-ESNetworking.git"

  s.license      = "MIT"

  s.author       = { "jiangyunfeng" => "554994782@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://gitlab-dev.shejijia.com/mobile-sjj-plt/component-ESNetworking.git", :branch => "change_swift" }

  s.source_files  = "ESNetworking"

s.subspec "API" do |ss|
ss.source_files = "ESNetworking/API/*.{h,swift,c,m}"
end

s.subspec "Common" do |ss|
ss.source_files = "ESNetworking/Config/*.{h,swift,c,m}"
end

  s.public_header_files = "ESNetworking/**/*.h"
#s.resource_bundles = { 'ESBasic' => ['ESNetworking/**/*.{storyboard,xib,xcassets,json,imageset,png}'] }

s.dependency 'ESBasic'
s.dependency 'Gloss'
s.dependency 'Moya/RxSwift'
s.dependency 'RealmSwift'
end
