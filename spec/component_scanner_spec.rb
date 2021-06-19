require 'spec_helper'

describe ComponentScanner do
    let(:target_uri) { 'http://localhost/' }
    let(:opts_user_agent) { 'Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0' }

    let(:typhoeus_code) { 200 }
    let(:typhoeus_body) { '' }
    let(:typhoeus_headers) { { 'Content-Type' => 'text/html; charset=utf-8' } }
    
    before :each do
        @scanner = ComponentScanner.new(
            target_uri,
            user_agent: opts_user_agent,
            threads: 20
        )

        Typhoeus.stub(/.*/) do
            Typhoeus::Response.new(code: typhoeus_code, body: typhoeus_body, headers: typhoeus_headers)
        end
    end

    describe '#possible_paths' do
        it 'returns two possible paths for the component to be found' do
          expect(@scanner.possible_paths('test').length).to eq 2
        end
    end
    
