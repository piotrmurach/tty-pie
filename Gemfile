source "https://rubygems.org"

gemspec

# gem "pastel", git: "https://github.com/piotrmurach/pastel"
gem "json", "2.4.1" if RUBY_VERSION == "2.0.0"

group :test do
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.5.0")
    gem "coveralls_reborn", "~> 0.21.0"
    gem "simplecov", "~> 0.21.0"
  end
end

group :metrics do
  gem "yardstick", "~> 0.9.9"
end
