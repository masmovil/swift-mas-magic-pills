Pod::Spec.new do |s|
  s.name             = 'MagicPills'
  s.version          = '0.1.0'
  s.summary          = 'Set of powerful utilities 💊.'

  s.description      = <<-DESC
Set of powerful utilities for development in Swift (Support for iOS, tvOS and mac)
DESC

  s.homepage         = 'https://github.com/bq/swift-magic-pills'
  s.license          = { :type => 'APACHE', :file => 'LICENSE' }
  s.author           = { 'bq' => 'info@bq.com' }
  s.source           = { :git => 'https://github.com/bq/swift-magic-pills.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bqreaders'

  s.swift_version = '4.2'
  s.ios.deployment_target = '11.0'

  s.source_files  = "Source", "Source/**/*.{swift}"

  s.frameworks = 'Foundation'
  #s.dependency 'RxSwift', '~> 4.3'
  
end
