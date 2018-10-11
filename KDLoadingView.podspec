Pod::Spec.new do |s|
  s.name         = "KDLoadingView"
  s.version      = "1.0.5"
  s.summary      = "A beautiful loading indicator inspired by material design."
  s.description  = "The KDLoadingView is a completely customizable loading indicator that can be used in any iOS app."
  s.homepage     = "https://github.com/KaiqueDamato/KDLoadingView.git"
  s.license      = "MIT"
  s.author       = { "Kaique Pantosi D'amato" => "kaiquedamato@icloud.com" }
  s.social_media_url   = "https://twitter.com/KaiqueDamato"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/KaiqueDamato/KDLoadingView.git", :tag => "1.0.5" }
  s.source_files = "KDLoadingView", "KDLoadingView/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
end
