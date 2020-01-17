require "mu/rest_client/version"
require 'net/http'
require 'uri'
require 'json'
require 'mu/result'
require 'mu/json'

module Mu
  module RestClient
    include Mu
    extend self

    def api_request(method: :get, domain:, scheme: 'https', path: '/', uri_params: {}, body_params: {}, headers: {}, success_codes: ['200'], is_json: true)
      result = request(
        method: method,
        scheme: scheme,
        domain: domain,
        path: path,
        body_params: body_params,
        uri_params: uri_params,
        headers: headers,
      )
      return result if result.error?
      response = result.data[:response]

      application_response(
        response: response,
        success_codes: success_codes,
        is_json: is_json,
      )
    end

    private

    def request_class(method:)
      case method
      when :get then Net::HTTP::Get
      when :post then Net::HTTP::Post
      when :delete then Net::HTTP::Delete
      when :put then Net::HTTP::Put
      when :patch then Net::HTTP::Patch
      else
        raise "HTTP method '#{method}' is not recognized."
      end
    end

    def request(method: :get, domain:, scheme: 'https', path: '/', uri_params: {}, body_params: {}, headers: {})
      draft_uri = "#{scheme}://#{domain}#{path}"
      if uri_params.any?
        draft_uri = "#{draft_uri}?#{URI.encode_www_form(uri_params)}"
      end
      uri = URI(draft_uri)
      Net::HTTP.start(uri.host, uri.port, use_ssl: scheme == 'https') do |http|
        request = request_class(method: method).new(uri)
        if headers.any?
          headers.each do |key, value|
            request[key] = value
          end
        end
        if body_params.any?
          request.body = ::JSON.generate(body_params)
        end
        response = http.request(request)
        Result.success(response: response)
      end
    end

    def application_response(response:, success_codes: ['200'], is_json: true)
      data = {
        response: response,
        http_code: response.code,
      }
      if is_json && response.body != nil
        result = ::Mu::JSON.parse(response.body)
        return result if result.error?

        data[:body] = result.unwrap
      end
      is_success = success_codes.include?(response.code)
      return Result.error(data).code!(:http_error) unless is_success

      Result.success(data)
    end
  end
end
