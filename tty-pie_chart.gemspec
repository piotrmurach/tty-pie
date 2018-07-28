lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tty/pie_chart/version"

Gem::Specification.new do |spec|
  spec.name          = "tty-pie_chart"
  spec.version       = TTY::PieChart::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = [""]

  spec.summary       = %q{Draw pie charts in your terminal window.}
  spec.description   = %q{Draw pie charts in your terminal window.}
  spec.homepage      = "https://piotrmurach.github.io/tty"
  spec.license       = "MIT"

  spec.files  = Dir.glob('lib/**/*.rb') + Dir.glob('bin/*')
  spec.files += Dir.glob('[A-Z]*') + Dir.glob('[a-z]*\.*')
  spec.files += Dir.glob('spec/**/*.rb')
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'pastel', '~> 0.7.2'
  spec.add_dependency 'tty-cursor', '~> 0.6.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
