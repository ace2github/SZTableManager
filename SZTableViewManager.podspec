Pod::Spec.new do |s|
  s.name        = 'SZTableViewManager'
  s.version     = '0.1.5'
  s.authors     = { 'Hui' => '173141667@qq.com' }
  s.homepage    = 'https://github.com/ace2github/SZTableManager'
  s.summary     = 'Powerful data driven content manager for UITableView.'
  s.source      = { :git => 'https://github.com/ace2github/SZTableManager.git',
                    :tag => s.version.to_s }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios, '.0'
  s.requires_arc = true
  s.source_files = 'SZTableViewManager/Core', 'SZTableViewManager/CellItems'
  # Swift support uses dynamic frameworks and is therefore only supported on iOS > 8.
  s.ios.deployment_target = '8.0'
end
