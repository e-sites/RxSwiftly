Pod::Spec.new do |s|
  s.name           = "RxSwiftly"
  s.platform       = :ios
  s.version        = "1.2.1"
  s.ios.deployment_target = "9.0"
  s.summary        = "An E-sites collection of RxSwift extensions."
  s.author         = { "Bas van Kuijck" => "bas@e-sites.nl" }
  s.license        = { :type => "MIT", :file => "LICENSE" }
  s.homepage       = "https://github.com/e-sites/#{s.name}"
  s.source         = { :git => "https://github.com/e-sites/#{s.name}.git", :tag => "v#{s.version.to_s}" }
  s.source_files   = 'Source/*.h'
  s.requires_arc   = true
  s.swift_versions = [ '4.2', '5.0' ]
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.frameworks    = 'Foundation', 'UIKit'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Source/Core/*.swift'
  end

  s.subspec 'UIKit' do |ss|
    ss.subspec 'UIApplication' do |sss|
      sss.source_files   = "Source/UIKit/UIApplication/*.{h,swift}"
    end
    ss.subspec 'UITextField' do |sss|
      sss.source_files   = "Source/UIKit/UITextField/*.{h,swift}"
    end
    ss.dependency "#{s.name}/Core"
  end

  s.subspec 'CoreMotion' do |ss|
    ss.frameworks    = 'CoreMotion'
    ss.subspec 'CMMotionManager' do |sss|
      sss.source_files   = "Source/CoreMotion/CMMotionManager/*.{h,swift}"
    end
    ss.dependency "#{s.name}/Core"
  end

  s.default_subspecs = 'Core', 'UIKit', 'CoreMotion'
end
