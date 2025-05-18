# frozen_string_literal: true

require_relative "error_logger_client/version"
require "net/http"
require "json"

module ErrorLoggerClient
  class Error < StandardError; end
  # Your code goes here...

  class << self
    def configure(api_key:, host)
      @api_key = api_key
      @host = host
    end

    def capture(exception, environment: "production")
      raise "ErrorLoggerClient not configured" unless @api_key && @host

      payload = {
        error_class: exception.class.to_s,
        message: exception.message,
        backtrace: exception.backtrace || [],
        environment: environment
      }

      uri = URI.join(@host, "/api/errors")
      request = Net::Http::Post.new(uri)
      request["Content-Type"] = 'application/json'
      request["X-API-KEY"] = @api_key
      request.body = payload.to_json

      Net::Http.start(uri.hostname, uri.port, use_ssl: uri.schema == 'https') do |http|
        http.request(request)
      end
    rescue => err
      warn "[ErrorLoggerClient] Failed to report error: #{err.message}"
    end
  end
end
