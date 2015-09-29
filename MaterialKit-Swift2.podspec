Pod::Spec.new do |s|
  s.name         = "MaterialKit-Swift2"
  s.version      = "0.4.1"
  s.summary      = "A fork of https://github.com/nghialv/MaterialKit using Swift 2 syntax."

  s.homepage     = "https://github.com/nghialv/MaterialKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Reese McLean" => "reese.mclean@prolifiq.com" }

  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/reesemclean/MaterialKit.git", :tag => s.version.to_s }

  s.module_name = 'MaterialKit'
  s.source_files  = "Source/*"
  s.requires_arc = true
end