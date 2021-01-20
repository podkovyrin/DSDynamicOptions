Pod::Spec.new do |s|
  s.name             = 'DSDynamicOptions'
  s.version          = '0.1.2'
  s.summary          = 'NSUserDefaults wrapper'

  s.description      = <<-DESC
NSUserDefaults wrapper with dynamically generated properties.
                       DESC

  s.homepage         = 'https://github.com/podkovyrin/DSDynamicOptions'
  s.license          = 'MIT'
  s.author           = { 'Andrew Podkovyrin' => 'podkovyrin@gmail.com' }
  s.source           = { :git => 'https://github.com/podkovyrin/DSDynamicOptions.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/podkovyr'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target  = '10.15'

  s.source_files = 'DSDynamicOptions/*'
end
