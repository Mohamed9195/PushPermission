
Pod::Spec.new do |spec|

spec.name         = "PushPermission"
spec.version      = "0.0.3"
spec.summary      = "Take all permission, and get any change to happen in it."
spec.description  = "using push protocol to get any update in permissions when calling framework object one time, and can use Push RXPermission View to show all permission."
spec.homepage     = "https://github.com/Mohamed9195/PushPermission"
spec.license      = "MIT"
spec.authors      = { "Mohamed Hashem" => "mohamedabdalwahab588@gmail.com" }
spec.platform     = :ios, "12.0"
spec.ios.deployment_target = "12.0"
spec.source       = { :git => "https://github.com/Mohamed9195/PushPermission.git", :tag => "#{spec.version}" }
spec.source_files  = "PushPermission"
spec.exclude_files = "Classes/Exclude"
spec.resources  = "PushPermission/*.{xib,png}"
#spec.resources = "PushPermission/location.png"
#spec.resources = "PushPermission/i-camera.png"
#spec.resources = "PushPermission/notification.png"
#spec.resources = "PushPermission/bluetooth.png"

spec.subspec 'App' do |app|
app.source_files = 'PushPermission/**/*.swift'
#app.resource_bundles = {'PushPermission' => ['PushPermission/Resources/**/*']}
end

spec.swift_version = "4.2"
spec.dependency 'RxSwift', '~> 5.1'
spec.dependency "RxCocoa", "~> 5.1"

#spec.resources = "Resources/PushPermission.xib"
#spec.source_files = "PushPermission/**/*.{swift,h,m,xib,storyboard}"
#spec.social_media_url   = "https://twitter.com/Mohamed Hashem"
#spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
#spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
#spec.resource  = "*png"
end
