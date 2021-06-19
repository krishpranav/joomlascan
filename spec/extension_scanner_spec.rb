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