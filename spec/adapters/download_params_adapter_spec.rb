# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DownloadParamsAdapter do
  let(:subject) { described_class.new(request_params: params) }

  describe '#adapt' do
    let(:architecture) { 'x86_64' }
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
    let(:operating_system) { 'apple-darwin18.0' }
    let(:version) { 'x86_64-apple-darwin18.0' }

    context 'with valid params' do
      it 'returns the adapted download_params' do
        download_params = {
          architecture: 'x86_64',
          operating_system: 'apple-darwin18.0'
        }
        expect(subject.adapt).to eq(download_params)
      end

      it 'extracts raw_curl_version from request_params' do
        expect { subject.adapt }
          .to change { subject.raw_curl_version }
          .from(nil)
          .to(raw_curl_version)
      end

      it 'extracts version' do
        expect { subject.adapt }
          .to change { subject.version }
          .from(nil)
          .to(version)
      end

      it 'extracts architecture' do
        expect { subject.adapt }
          .to change { subject.architecture }
          .from(nil)
          .to(architecture)
      end

      it 'extracts operating_system' do
        expect { subject.adapt }
          .to change { subject.operating_system }
          .from(nil)
          .to(operating_system)
      end
    end

    context 'with invalid params' do
      let(:params) { {} }

      it 'raises expected error' do
        expected = [DownloadParamsAdapter::Error, 'curl_raw_version not found']
        expect { subject.adapt }.to raise_error(*expected)
      end
    end
  end
end
