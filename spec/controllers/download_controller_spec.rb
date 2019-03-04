require "rails_helper"

RSpec.describe DownloadController do
  let(:download_url) {}
  let(:params) { { raw_curl_version => nil } }
  let(:raw_curl_version) do
    'curl 7.54.0 (x86_64-apple-darwin18.0) libcurl/7.54.0 ' \
      'LibreSSL/2.6.4 zlib/1.2.11 nghttp2/1.24.1Protocols:' \
      ' dict file ftp ftps gopher http https imap imaps ld' \
      'ap ldaps pop3 pop3s rtsp smb smbs smtp smtps telnet' \
      ' tftp Features: AsynchDNS IPv6 Largefile GSS-API Ke' \
      'rberos SPNEGO NTLM NTLM_WB SSL libz HTTP2 UnixSocke' \
      'ts HTTPS-proxy '
  end

  describe "POST create" do
    context "with valid params" do
      it "redirects to download_url" do
        post :create, params: params
        expect(response).to redirect_to("https://dowload/darwin/amd64")
      end
    end
  end
end
