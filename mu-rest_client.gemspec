lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mu/rest_client/version"

Gem::Specification.new do |spec|
  spec.name          = "mu-rest_client"
  spec.version       = Mu::RestClient::VERSION
  spec.authors       = ["olistik"]
  spec.email         = ["root@olisti.co"]

  spec.summary       = %q{Yet another REST client implementation.}
  spec.description   = %q{This is a REST client I developed for fun.}
  spec.homepage      = "https://source.olisti.co/olistik/mu-rest-client"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://source.olisti.co/olistik/mu-rest-client"
  spec.metadata["changelog_uri"] = "https://source.olisti.co/olistik/mu-rest-client/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "mu-result", "~> 1.2"
  spec.add_runtime_dependency "mu-json", "~> 0.1"
end
