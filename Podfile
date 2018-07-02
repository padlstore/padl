# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'padl' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for padl

  pod 'Firebase/Storage'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod "Macaw", "0.9.1"
  pod 'JSQMessagesViewController'
  pod 'FontAwesomeIconFactory'
  pod 'Alamofire', '~> 4.7'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'AlgoliaSearch-Client-Swift'
  pod 'Stripe'
  pod 'Nuke', '~> 7.0'
  pod 'TKSubmitTransition', :git => 'https://github.com/entotsu/TKSubmitTransition.git', :branch => 'swift4'
  pod 'FSPagerView'
  pod 'CFNotify'
  pod 'NotificationBannerSwift'
  pod 'InstantSearch', '~> 2.0'
  pod 'Kingfisher', '~> 4.0'
  pod "Preheat"

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end
