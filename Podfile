# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SchoolApp' do
  use_frameworks!

	pod 'Kingfisher', '~> 5.3.1' 		#for images caching
	pod 'Alamofire' , '~> 5.0.0-beta.4'
	pod "PromiseKit", "~> 6.8"		# like RxSwift

	pod 'Google-Mobile-Ads-SDK'
	#pod 'Firebase/Analytics'
	#pod 'Firebase/AdMob'

	pod 'OneSignal', '>= 2.6.2', '< 3.0'

	pod 'IQKeyboardManagerSwift'
	#pod "Hero"

	pod 'YouTubePlayer'

	pod 'SwiftyOnboard'
	#pod 'MaterialShowcase'

  target 'OneSignalNotificationServiceExtension' do
    pod 'OneSignal', '>= 2.6.2', '< 3.0'
  end

  target 'SchoolAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SchoolAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end




################ AFTER INSTALLING PODS ######################
post_install do |installer|
installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
end

installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end
end
end