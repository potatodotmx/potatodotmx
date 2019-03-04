# frozen_string_literal: true

# :nodoc:
class DownloadParamsAdapter
  include ActiveModel::Model

  class Error < StandardError; end

  attr_accessor :architecture,
                :operating_system,
                :raw_curl_version,
                :request_params,
                :version

  def build_download_params
    {
      architecture: @architecture,
      operating_system: @operating_system
    }
  end

  def extract_curl_raw_version
    @raw_curl_version = @request_params.keys.find { |key| key =~ /curl/ }
    raise Error, 'curl_raw_version not found' unless @raw_curl_version
  end

  def adapt
    extract_curl_raw_version
    extract_curl_version
    extract_archticture_and_operating_system
    build_download_params
  end

  def extract_curl_version
    @version =
      @raw_curl_version
      .split(' ')
      .at(2)
      .slice(1..-2)
  end

  def extract_archticture_and_operating_system
    @architecture, @operating_system = @version.split('-', 2)
  end
end
