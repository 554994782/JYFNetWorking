post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
    end

platform :ios, '8.0'
inhibit_all_warnings!

source 'https://github.com/Cocoapods/Specs.git'
source 'https://github.com/554994782/JYFSpecs.git'


target 'JYFNetworkingDemo' do
    use_frameworks!
    pod 'JYFBasic', :git => 'https://github.com/554994782/JYFBasic.git', :branch => ‘develop’
    pod 'Gloss'
    pod 'Moya/RxSwift'
    pod 'RealmSwift'
    pod 'CryptoSwift'
    pod 'AMapLocation-NO-IDFA'
end

target 'JYFNetworking' do
    use_frameworks!
    pod 'JYFBasic', :git => 'https://github.com/554994782/JYFBasic.git', :branch => ‘develop’
    pod 'Gloss'
    pod 'Moya/RxSwift'
    pod 'RealmSwift' '~> 3.1.0'
    pod 'CryptoSwift'
    pod 'AMapLocation-NO-IDFA'
end

