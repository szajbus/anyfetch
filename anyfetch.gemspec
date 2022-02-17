# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "anyfetch/version"

Gem::Specification.new do |spec|
  spec.name          = "anyfetch"
  spec.version       = Anyfetch::VERSION
  spec.authors       = ["Michał Szajbe"]
  spec.email         = ["michal.szajbe@gmail.com"]

  spec.summary       = %q{Fetch files via any protocol.}
  spec.description   = %q{Anyfetch provides abstraction layer around multiple protocols to allow accessing files in uniform way.}
  spec.homepage      = "https://github.com/szajbus/anyfetch"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'terrapin'
  spec.add_dependency 'mime-types'
  spec.add_dependency 'open_uri_redirections'
  spec.add_dependency 'net-sftp'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
