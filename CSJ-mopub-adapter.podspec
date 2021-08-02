Pod::Spec.new do |s|
  s.name             = 'CSJ-mopub-adapter'
  s.version          = '1.0.0'
  s.summary          = 'CSJ adapter for mopub'
  s.description      = <<-DESC
  bytedance CSJ adapter for mopub 
                       DESC

  s.license             = { :type => 'MIT', :file => 'CSJAdapter/LICENSE' }

  s.author              = { 'zengyang' => 'zywork@bytedance.com' }

  s.homepage            = 'https://www.pangle.cn'
  
  s.source              = { :http => 'https://sf3-fe-tos.pglstatp-toutiao.com/obj/pangle-sdk-static/Adapter/Mopub/1.0.0/CSJAdapter.zip' }

  s.pod_target_xcconfig = {"EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64 arm64e armv7 armv7s", "EXCLUDED_ARCHS[sdk=iphoneos*]" => "i386 x86_64"}

  s.platform            = :ios, "10.0"

  s.static_framework    = true

  s.source_files        = "CSJAdapter/*.{h,m}"

  s.dependency "Ads-CN","3.7.0.8"

  s.dependency "mopub-ios-sdk/Core","~> 5.17.0"

  s.dependency "mopub-ios-sdk/NativeAds","~> 5.17.0"

  

  # pod trunk push CSJ-mopub-adapter.podspec --allow-warnings --verbose --use-libraries --skip-import-validation
  # pod trunk push CSJ-mopub-adapter.podspec --allow-warnings --verbose --skip-import-validation

end
