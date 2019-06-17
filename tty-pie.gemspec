lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tty/pie/version"

Gem::Specification.new do |spec|
  spec.name          = "tty-pie"
  spec.version       = TTY::Pie::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["me@piotrmurach.com"]

  spec.summary       = %q{Draw pie charts in your terminal window.}
  spec.description   = %q{Draw pie charts in your terminal window.}
  spec.homepage      = "https://piotrmurach.github.io/tty"
  spec.license       = "MIT"

  spec.files         = Dir['{lib,spec,examples}/**/*.rb']
  spec.files        += Dir['{bin,tasks}/*', 'tty-pie.gemspec']
  spec.files        += Dir['README.md', 'CHANGELOG.md', 'LICENSE.txt', 'Rakefile']
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'pastel', '~> 0.7.3'
  spec.add_dependency 'tty-cursor', '~> 0.7'

  spec.add_development_dependency 'bundler', '>= 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
