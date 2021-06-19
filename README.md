# joomlascan
A simple joomla vulnerability scanner built in ruby

[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)

# Installation
```
git clone https://github.com/krishpranav/joomlascan
cd joomlascan
gem install bundler && bundle install
```

# Usage
```
usage: joomlascan.rb [options]
Basic options
    -u, --url              The Joomla URL/domain to scan.
    --basic-auth           <username:password> The basic HTTP authentication credentials
    -v, --verbose          Enable verbose mode
Enumeration options
    -a, --scan-all         Scan for all vulnerable extensions
    -c, --scan-components  Scan for vulnerable components
    -m, --scan-modules     Scan for vulnerable modules
    -t, --scan-templates   Scan for vulnerable templates
    -q, --quiet            Scan using only passive methods
Advanced options
    --disable-tls-checks   Disable SSL/TLS certificate verification.
    --follow-redirection   Automatically follow redirections
    --no-colour            Disable colours in output
    --proxy                <[protocol://]host:port> HTTP, SOCKS4 SOCKS4A and SOCKS5 are supported. If no protocol is given, HTTP will be used
    --proxy-auth           <username:password> The proxy authentication credentials
    --threads              The number of threads to use when multi-threading requests
    --user-agent           The user agent string to send with all requests
```

- make sure you have ruby [2.4.4 or above] is installed on your system
