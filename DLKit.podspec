#
# Be sure to run `pod lib lint DLKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DLKit'
  s.version          = '0.1.3'
  s.summary          = 'Http请求,获取设备信息,获取App信息,Base64加解密,文件下载器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LengYi/DLKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '707689817@qq.com' => '707689817@qq.com' }
  s.source           = { :git => 'https://github.com/LengYi/DLKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  #s.source_files = 'DLKit/Classes/**/*'

  s.subspec 'DLHttp' do |http|
      http.source_files = 'DLKit/Classes/Base/DLNet/Request/**/*'
  end

  s.subspec 'UIDevice+extended' do |dev|
      dev.source_files = 'DLKit/Classes/Base/DLUIKitExtended/Device/**/*'
  end

  s.subspec 'DLAppInfo' do |info|
    info.source_files = 'DLKit/Classes/Base/App/**/*'
  end

  s.subspec 'DLDESBase64' do |des|
    des.source_files = 'DLKit/Classes/Base/Encrypt/DESBase64/**/*'
  end

  s.subspec 'DLDownloadFile' do |download|
    download.source_files = 'DLKit/Classes/Base/DLNet/Download/**/*'
  end

   s.subspec 'DLDocumentPath' do |documentPath|
    documentPath.source_files = 'DLKit/Classes/Base/DLPath/**/*'
  end

  # s.resource_bundles = {
  #   'DLKit' => ['DLKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'AdSupport','Foundation'
   s.dependency 'GTMBase64', '~> 1.0.0'
end
