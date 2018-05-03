Gem::Specification.new do |s|
  s.name        = 'rake_flow_visualizer'
  s.version     = '0.0.0'
  s.date        = '2018-05-02'
  s.summary     = 'A simple tool to visualize the order of Rake tasks of an existing project.'
  s.description = 'This gem will help you determine the order of task execution of an existing project using Rake. It may help you reverse engineer a complex project.'
  s.authors     = 'Rob Fors'
  s.email       = 'mail@robfors.com'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.executables = ['rake_flow_visualizer']
  s.homepage    = 'https://github.com/robfors/quack_concurrency'
  s.license     = 'MIT'
  s.add_runtime_dependency 'rake', '~> 0'
end
