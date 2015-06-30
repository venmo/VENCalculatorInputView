Pod::Spec.new do |s|
  s.name         = 'CalculatorInput'
  s.version      = '2.0.0'
  s.summary      = 'Venmo-style calculator keyboard for iOS'
  s.description  = 'A pretty calculator keyboard for iOS. Use it as a standalone keyboard or use our CalculatorInputTextField.'

  s.homepage     = 'https://github.com/venmo/VENCalculatorInputView'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Ayaka Nonaka' => 'ayaka@venmo.com' }
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => 'https://github.com/venmo/VENCalculatorInputView.git',
                     :tag => "v#{s.version}"
                   }
  s.source_files = 'CalculatorInput/**/*.{h,m}'
  s.resources    = ['CalculatorInput/**/*.{xib,png}']
end
