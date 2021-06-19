require 'spec_helper'

describe ExtensionScanner do

    let(:target_uri) { 'http://localhost' }
    let(:data_file) { 'data/modules.json' }
    let(:opts_user_agent) { 'Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0' }
    let(:opts_threads) { 20 }
    let(:opts_follow_redirection) { nil }
    let(:opts_basic_auth) { nil }
    let(:opts_proxy) { nil }
    let(:opts_proxy_auth) { nil }
  
    let(:typhoeus_code) { 200 }
    let(:typhoeus_body) { '' }
    let(:typhoeus_headers) { { 'Content-Type' => 'text/html; charset=utf-8' } }

    before :each do
        @scanner = ExtensionScanner.new(target_uri, data_file, {
            :user_agent => opts_user_agent,
            :threads => opts_threads,
            :follow_redirection => opts_follow_redirection,
            :basic_auth => opts_basic_auth,
            :proxy_auth => opts_proxy_auth
        })

        Typhoeus.stub(/.*/) do
            Typhoeus::Response.new(code: typhoeus_code, body: typhoeus_body, headers: typhoeus_headers)
          end
        end
      