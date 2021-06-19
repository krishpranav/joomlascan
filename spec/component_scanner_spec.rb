require 'spec_helper'

describe ComponentScanner do
    let(:target_uri) { 'http://localhost/' }
    let(:opts_user_agent) { 'Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0' }

    let(:typhoeus_code) { 200 }
    let(:typhoeus_body) { '' }
    let(:typhoeus_headers) { { 'Content-Type' => 'text/html; charset=utf-8' } }
    
end