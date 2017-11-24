
Pod::Spec.new do |s|
  s.name             = 'HexPatternView'
  s.version          = '1.0.0'
  s.summary          = 'Create Beautiful hex design View.'

  s.homepage         = 'https://github.com/satishbabariya/HexPatternView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Satish Babariya' => 'satish.babariya@gmail.com' }
  s.source           = { :git => 'https://github.com/satishbabariya/HexPatternView.git', :tag => s.version.to_s }

  s.ios.deployment_target = "9.0"

  s.source_files = 'HexPatternView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HexPatternView' => ['HexPatternView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  s.ios.frameworks = 'UIKit', 'Foundation'

end
