lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "butts/version"

Gem::Specification.new do |spec|
  spec.name          = "butts"
  spec.version       = Butts::VERSION
  spec.authors       = ['Kelly Joseph Price']

  spec.summary       = %q{Butts}
  spec.description   = %q{Heh, Butts}
  spec.license       = "MIT"

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_runtime_dependency "faker"
end
