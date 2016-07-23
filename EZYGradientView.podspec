Pod::Spec.new do |s|

  s.name              = 'EZYGradientView'
  s.version           = '1.2'
  s.platform          = :ios, '8.0'
  s.license           = { :type => 'MIT' }
  s.homepage          = 'https://github.com/shashankpali/EZYGradientView'
  s.authors           = { 'Shashank Pali' => 'shank.pali@gmail.com' }
  s.summary           = 'Create gradients without a single line of code'
  s.source            = { :git => 'https://github.com/shashankpali/EZYGradientView.git', :tag => s.version }
  s.requires_arc      = true
  s.default_subspecs  = 'Default'

  s.subspec 'Default' do |ss|
    ss.source_files   = 'EZYGradientView/*.swift'
  end

  s.subspec 'ObjC' do |ss|
    ss.source_files   = 'EZYGradientView/*.{h,m}'
  end

end
