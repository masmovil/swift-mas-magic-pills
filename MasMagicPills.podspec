Pod::Spec.new do |s|
  s.name             = 'MasMagicPills'
  s.version          = '3.12.0'
  s.swift_version    = '5.0'
  s.summary          = 'Set of powerful utilities 💊.'

  s.description      = <<-DESC
Set of powerful utilities for development in Swift (Support for iOS, tvOS and mac)
DESC

  s.homepage         = 'https://github.com/masmovil/swift-mas-magic-pills'
  s.license          = { :type => 'APACHE', :file => 'LICENSE' }
  s.authors          = { 'MásMóvil' => 'info@grupomasmovil.com' }
  s.source           = { :git => 'https://github.com/masmovil/swift-mas-magic-pills.git', :tag => "v#{s.version.to_s}" }
  s.social_media_url = 'https://twitter.com/masmovil'

  s.frameworks = 'Foundation'

  s.ios.deployment_target = '14.1'
  s.ios.frameworks = 'UIKit'
  s.ios.source_files  = 'Source/Foundation/**/*.swift', 'Source/UIKit/**/*.swift', 'Source/SwiftUI/**/*.swift'

  s.osx.deployment_target = '11.0'
  s.osx.frameworks = 'AppKit'
  s.osx.source_files  = 'Source/Foundation/**/*.swift', 'Source/SwiftUI/**/*.swift'

  s.watchos.deployment_target = '7.1'
  s.watchos.frameworks = 'UIKit', 'WatchKit'
  s.watchos.source_files  = 'Source/Foundation/**/*.swift'
  s.watchos.exclude_files = 'Source/Foundation/Extensions/StringExtensions+Formating.swift', 
    'Source/Foundation/Extensions/CALayerExtensions.swift', 
    'Source/Foundation/Extensions/CGFloatExtensions.swift', 
    'Source/Foundation/Extensions/NSAttributedStringExtensions.swift'

  s.tvos.deployment_target = '14.1'
  s.tvos.frameworks = 'UIKit'
  s.tvos.source_files  = 'Source/Foundation/**/*.swift', 'Source/UIKit/**/*.swift', 'Source/SwiftUI/**/*.swift'
end
