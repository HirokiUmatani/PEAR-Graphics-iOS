Pod::Spec.new do |s|
   s.name     = 'PEAR-Graphics-iOS'
   s.version  = '0.1.0'
   s.platform = :'ios', '8.0'
   s.license  = 'MIT'
   s.summary  = 'This library can to draw on canvas in iOS'
   s.homepage = 'https://github.com/HirokiUmatani/PEAR-Graphics-iOS'
   s.author   = { "HirokiUmatani" => "info@pear.chat" }
   s.source   = { :git => 'https://github.com/HirokiUmatani/PEAR-Graphics-iOS.git', :tag => s.version.to_s }
   s.source_files = 'PEAR-Graphics-iOS/*.{h,m}'
   s.requires_arc = true
end
