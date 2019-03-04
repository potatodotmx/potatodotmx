# frozen_string_literal: true

# :nodoc:
class DownloadController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    byebug
    @download = Download.new(download_params)

    return redirect_to @download.url if @download.valid?

    raise 'not implemented'
  end

  private

  def download_params
    DownloadParamsAdapter.new(request_params: params).adapt
  end
end
