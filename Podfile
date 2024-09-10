# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'SwiftUI-Chat-Demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  #Socket.IO-client for iOS
  pod 'Socket.IO-Client-Swift', '~> 16.0.1'
  
  pod 'Starscream', '4.0.4'
  # Pods for SwiftUI-Chat-Demo

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "17.0"
    end
  end
end
