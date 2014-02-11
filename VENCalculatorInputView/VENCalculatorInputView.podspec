Pod::Spec.new do |s|
  s.name         = "VENCalculatorInputView"
  s.version      = "1.0.0"
  s.summary      = "Venmo-style calculator keyboard for iOS"
  s.description  = <<-DESC
                   Venmo-style calculator keyboard for iOS
                   DESC

  s.homepage     = "https://github.com/venmo/VENCalculatorInputView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Ayaka Nonaka" => "ayaka@venmo.com" }
  s.platform     = :ios, '5.0'
  s.source_files = '**/*.{h,m}'
  s.resources    = ["**/*.xib"]
  s.requires_arc = true
end
