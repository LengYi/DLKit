#
# Be sure to run `pod lib lint DLKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DLKit'
  s.version          = '0.3.9'
  s.summary          = '构建App常用的基本功能库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
   Http请求,获取设备信息,获取App信息,Base64加解密,文件下载器,网络数据打包解析,UIKitExtened,KeyChain数据存储,AOP打点统计子系统,Http网络请求数据拦截修改管理子系统,
   广告无限自动循环轮播组件,iOS常用宏,ViewController通用架构(Loading加载,网络异常,下拉上拉刷新)
                       DESC

  s.homepage         = 'https://github.com/LengYi/DLKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '707689817@qq.com' => '707689817@qq.com' }
  s.source           = { :git => 'https://github.com/LengYi/DLKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.default_subspec = 'Classes'     # 需要设置否则使用该库时,无法按正常文件结构浏览

  s.subspec 'Classes' do |classes|

    classes.subspec 'Base' do |base|
      base.subspec 'DLAppInfo' do |info|
        info.source_files = 'DLKit/Classes/Base/App/**/*'
        info.public_header_files = 'DLKit/Classes/Base/App/**/*.h'
      end
      
      base.subspec 'Define' do |publedefine|
        publedefine.source_files = 'DLKit/Classes/Base/Define/**/*'
      end 
        
      base.subspec 'DLNet' do |dlnet|
         dlnet.subspec 'DLDownloadFile' do |download|
           download.source_files = 'DLKit/Classes/Base/DLNet/DLDownloadFile/**/*'
           download.dependency 'DLKit/Classes/Base/DLUIKitExtended/NSURL'   ##依赖NSURL+DLAdditions 这个subspecs
         end
        dlnet.subspec 'DLHttp' do |http|
          http.source_files = 'DLKit/Classes/Base/DLNet/DLHttp/**/*'
        end
        dlnet.subspec 'DLNetReachability' do |reachable|
          reachable.source_files = 'DLKit/Classes/Base/DLNet/DLNetReachability/**/*'
          reachable.requires_arc = false
        end
       end 

      base.subspec 'DLPath' do |dlpath|
        dlpath.source_files = 'DLKit/Classes/Base/DLPath/**/*'
      end

      base.subspec 'DLUIKitExtended' do |uikit|
        uikit.subspec 'Device' do |device|
          device.source_files = 'DLKit/Classes/Base/DLUIKitExtended/Device/**/*'
        end
        uikit.subspec 'NSURL' do |nsurl|
          nsurl.source_files = 'DLKit/Classes/Base/DLUIKitExtended/NSURL/**/*'
        end
        uikit.subspec 'NSString' do |string|
          string.source_files = 'DLKit/Classes/Base/DLUIKitExtended/NSString/**/*'
        end
        uikit.subspec 'NSData' do |data|
          data.source_files = 'DLKit/Classes/Base/DLUIKitExtended/NSData/**/*'
        end
        uikit.subspec 'NSDate' do |date|
          date.source_files = 'DLKit/Classes/Base/DLUIKitExtended/NSDate/**/*'
        end
        uikit.subspec 'NSObject' do |obj|
          obj.source_files = 'DLKit/Classes/Base/DLUIKitExtended/NSObject/**/*'
        end

      end

      base.subspec 'DLUIKitSafeExtended' do |safekit|
        safekit.subspec 'NSMutableArray' do |array|
          array.source_files = 'DLKit/Classes/Base/DLUIKitSafeExtended/NSMutableArray/**/*'
          array.dependency 'DLKit/Classes/Base/DLUIKitExtended/NSObject'
        end
        safekit.subspec 'NSMutableDictionary' do |dic|
          dic.source_files = 'DLKit/Classes/Base/DLUIKitSafeExtended/NSMutableDictionary/**/*'
          dic.dependency 'DLKit/Classes/Base/DLUIKitExtended/NSObject'
        end
      end 
        
      base.subspec 'Encrypt' do |encrypt|
        encrypt.subspec 'DESBase64' do |base64|
          base64.source_files = 'DLKit/Classes/Base/Encrypt/DESBase64/**/*'
          base64.dependency 'GTMBase64', '~> 1.0.0'
        end
        encrypt.subspec 'AES128' do |aes|
          aes.source_files = 'DLKit/Classes/Base/Encrypt/AES128/**/*'
          aes.dependency 'GTMBase64', '~> 1.0.0'
        end
      end

      base.subspec 'DLData' do |dldata|
        dldata.source_files = 'DLKit/Classes/Base/DLData/**/*'
        end

        base.subspec 'Storage' do |storage|
          storage.source_files = 'DLKit/Classes/Base/Storage/KeyChain/**/*'
          end
    end

    classes.subspec 'Assist' do |assist|
      assist.subspec 'DLLog' do |log|
          log.source_files = 'DLKit/Classes/Assist/Statistics/Log/DLLog/**/*'
          log.dependency 'DLKit/Classes/Base/DLUIKitExtended/NSDate'
      end
      assist.subspec 'AOPStastic' do |stastic|
      stastic.source_files = 'DLKit/Classes/Assist/Statistics/AOPStatistic/**/*'
      end

      assist.subspec 'HttpMock' do |mock|
        mock.source_files = 'DLKit/Classes/Assist/HttpMock/**/*'
        mock.dependency 'GYHttpMock', '~> 1.0.1'
      end
    end


    classes.subspec 'ViewComponent' do |component|
      component.subspec 'CircleBanner' do |circleBanner|
        circleBanner.source_files = 'DLKit/Classes/ViewComponent/ADCircleBanner/**/*'
       end
    end 

    classes.subspec 'Vendors' do |vendor|
      vendor.subspec 'TablePullToRefresh' do |tableRefresh|
        tableRefresh.source_files = 'DLKit/Classes/Vendors/TablePullToRefresh/**/*'
        tableRefresh.dependency 'SVPullToRefresh','~> 0.4.1'
      end
      vendor.subspec 'UIKitEx' do |kitEx|
        kitEx.subspec 'Segment' do |seg|
          seg.source_files = 'DLKit/Classes/Vendors/UIKitEx/Segment/**/*'
        end
      end
    end
    
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'AdSupport','Foundation'
end
