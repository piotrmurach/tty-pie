# frozen_string_literal: true

require_relative "lib/tty/pie/version"

Gem::Specification.new do |spec|
  spec.name          = "tty-pie"
  spec.version       = TTY::Pie::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = "Draw pie charts in your terminal window."
  spec.description   = "Draw pie charts in your terminal window."
  spec.homepage      = "https://ttytoolkit.org"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
    spec.metadata["bug_tracker_uri"] = "https://github.com/piotrmurach/tty-pie/issues"
    spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/tty-pie/blob/master/CHANGELOG.md"
    spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/tty-pie"
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/tty-pie"
  end
  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_dependency "pastel", "~> 0.8"
  spec.add_dependency "tty-cursor", "~> 0.7"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"
end
