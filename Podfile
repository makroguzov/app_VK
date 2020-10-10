# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'app_VK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire', '~> 5.2'
  pod 'SDWebImage', '~> 5.8.4'
  pod 'RealmSwift', '~> 5.3.5'
  pod 'JGProgressHUD', '~> 2.1'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
              config.build_settings['EXCLUDED_ARCHS[sdk=watchsimulator*]'] = 'arm64'
              config.build_settings['EXCLUDED_ARCHS[sdk=appletvsimulator*]'] = 'arm64'
      
          end
      end
  end
  
#  target 'app_VKTests' do
#    inherit! :search_paths
#    # Pods for testing
#  end
#
#  target 'app_VKUITests' do
#    # Pods for testing
#  end

end
