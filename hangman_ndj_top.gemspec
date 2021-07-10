require_relative 'lib/hangman_ndj_top/version'

Gem::Specification.new do |spec|
  spec.name          = "hangman_ndj_top"
  spec.version       = HangmanNdjTop::VERSION
  spec.authors       = ["NaiveDJack"]
  spec.email         = ["naivedjack@protonmail.com"]

  spec.summary       = "A CLI game of Hangman featuring ASCII art. by Daniele Latella(github.com/naivedjack) Stickman art by Joan G. Stark @ asciiart.eu Project is part of The Odin Project curriculum"
  spec.homepage      = "https://github.com/NaiveDJack/hangman_ndj_top"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/NaiveDJack/hangman_ndj_top"
  spec.metadata["changelog_uri"] = "https://github.com/NaiveDJack/hangman_ndj_top#readme"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
