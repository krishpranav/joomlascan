require_relative 'scanner'

class FingerprintScanner < Scanner

    def initialize(target_uri, opts)
        super(target_uri, opts)

        @cached_index_results = {}
    end


    def common_resp_headers
        [
          'Access-Control-Allow-Origin',
          'Accept-Patch',
          'Accept-Ranges',
          'Age',
          'Allow',
          'Cache-Control',
          'Connection',
          'Content-Disposition',
          'Content-Encoding',
          'Content-Language',
          'Content-Length',
          'Content-Location',
          'Content-MD5',
          'Content-Range',
          'Content-Type',
          'Date',
          'ETag',
          'Expires',
          'Last-Modified',
          'Link',
          'Location',
          'P3P',
          'Pragma',
          'Proxy-Authenticate',
          'Public-Key-Pins',
          'Refresh',
          'Retry-After',
          'Set-Cookie',
          'Status',
          'Strict-Transport-Security',
          'Trailer',
          'Transfer-Encoding',
          'Upgrade',
          'Vary',
          'Via',
          'Warning',
          'WWW-Authenticate',
          'X-Frame-Options',
          'X-UA-Compatible',
          'X-Content-Duration',
          'X-Content-Type-Options'
        ]
    end

    def registration_uri
        '/index.php?option=com_users&view=registration'
    end
    
