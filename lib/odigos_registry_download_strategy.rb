# typed: false
# frozen_string_literal: true

require "download_strategy"
require "json"

# Downloads an Odigos CLI archive from registry.odigos.io, authenticating with
# the customer's Odigos on-prem token (HOMEBREW_ODIGOS_ONPREM_TOKEN).
class OdigosRegistryDownloadStrategy < CurlDownloadStrategy
  TOKEN_ENV = "HOMEBREW_ODIGOS_ONPREM_TOKEN"

  def fetch(timeout: nil)
    meta[:headers] ||= []
    meta[:headers] << "Authorization: Bearer #{registry_bearer}"
    super
  end

  private

  def onprem_token
    token = ENV.fetch(TOKEN_ENV, "").strip
    return token unless token.empty?

    raise CurlDownloadStrategyError.new(url, <<~EOS)
      Installing the Odigos CLI requires your Odigos on-prem token:
        export #{TOKEN_ENV}=<your on-prem token>
    EOS
  end

  # Exchanges the on-prem token for a short-lived registry token, as `docker login` does.
  def registry_bearer
    uri = URI(url)
    repo = uri.path[%r{\A/v2/(.+)/blobs/}, 1]
    token_url = "#{uri.scheme}://#{uri.host}/token?service=#{uri.host}&scope=repository:#{repo}:pull"
    result = curl_output("--fail", "--user", "odigos:#{onprem_token}", token_url, secrets: [onprem_token])
    unless result.success?
      raise CurlDownloadStrategyError.new(url, "the Odigos registry rejected #{TOKEN_ENV}; check that it is valid and not expired")
    end

    JSON.parse(result.stdout).fetch("token")
  end
end
