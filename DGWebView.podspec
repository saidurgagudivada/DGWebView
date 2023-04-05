Pod::Spec.new do |s|
s.name             = 'DGWebView'  
s.version          = '1.0.0'  
s.summary          = 'Compatible for iOS.' 
s.homepage         = 'https://github.com/saidurgagudivada/DGWebView' 
s.license          = { :type => 'MIT', :file => "LICENSE"  }
s.author           = { 'username' => 'saidurgagudivada@gmail.com' } 
s.source           = { :git => 'https://github.com/saidurgagudivada/DGWebView.git', :tag =>  '1.0.0' } 
s.ios.deployment_target = '12.0'
s.source_files  = 'DGWebView/*.{swift}'
s.framework     = 'SystemConfiguration'
s.static_framework = true
end