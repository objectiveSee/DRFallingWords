Pod::Spec.new do |s|
  s.name     = 'DRFallingWords'
  s.version  = '1.0'
  s.platform = :ios
  s.ios.deployment_target = '6.0'
  s.license  = 'MIT'
  s.summary  = 'Animate strings in a sexy way'
  s.homepage = 'https://github.com/objectiveSee/DRFallingWords'
  s.author   = { "Danny Ricciotti" => "dan.ricciotti@gmail.com" }
  s.source   = { :git => 'https://github.com/objectiveSee/DRFallingWords', :tag=>'v1.0' }
  s.source_files = 'DRFallingWords/DRFallingWordLabel.*','DRFallingWords/DRFallingWordsView.*'
  s.requires_arc = true
end
