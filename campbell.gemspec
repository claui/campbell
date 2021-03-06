# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'campbell/version'

Gem::Specification.new do |spec|
  spec.name          = "campbell"
  spec.version       = Campbell::VERSION
  spec.authors       = ["Claudia"]
  spec.email         = ["claui@users.noreply.github.com"]

  spec.summary       = "Ruby gem for rendering glyphs akin to the MMOARG Ingress"
  spec.description   = "This Ruby gem renders glyphs, which are a key element in the massively-multiplayer augmented reality game Ingress."
  spec.homepage      = "https://github.com/claui/campbell"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/claui/campbell"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  all_files = `git ls-files -z`.split(" ")
  spec_test_files, spec.files = all_files.partition do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "drawille", "~> 0.3"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
