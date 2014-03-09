Pod::Spec.new do |s|
  s.name         = "DPKit-NSTableRowView"
  s.version      = "0.0.1"
  s.summary      = "DPKit-NSTableRowView"
  s.homepage     = "http://dpostigo.com"
  s.license      = 'BSD'
  s.author       = { "Dani Postigo" => "dani@firstperson.is" }


  s.source       = { :git => "https://github.com/dpostigo/DPKit-NSTableRowView.git", :tag => s.version.to_s }
  s.platform     = :osx, '10.8'


  s.dependency     'DPKit-Utils'
  s.dependency     'DPKit-Styles'
  s.dependency     'DPKit-NSTextField'
  s.frameworks   = 'Foundation', 'QuartzCore'
  s.requires_arc = true

  s.source_files = 'DPKit-NSTableRowView/*.{h,m}'



  
end
