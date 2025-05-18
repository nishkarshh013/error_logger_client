# frozen_string_literal: true

require_relative "lib/error_logger_client/version"

Gem::Specification.new do |spec|
  spec.name = "error_logger_client"
  spec.version = ErrorLoggerClient::VERSION
  spec.authors = ["Nishkarsh Sahu"]
  spec.email = ["nishkarshsahu007@gmail.com"]

  spec.summary = "A lightweight error logging client to capture and send errors to a central Rails-based logger server."
  spec.description = "This gem allows your Ruby on Rails app to report exceptions to a centralized error logger server via API. Useful for creating your own Sentry-lite system."
  spec.homepage = "https://github.com/nishkarshh013/error_logger_client"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # Optional for private servers
  # spec.metadata["allowed_push_host"] = "https://your-private-gem-server.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nishkarshh013/error_logger_client"
  spec.metadata["changelog_uri"] = "https://github.com/nishkarshh013/error_logger_client/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) || f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Add any dependencies your client gem needs
  # e.g., spec.add_dependency "httparty"
end
