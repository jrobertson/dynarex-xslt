Gem::Specification.new do |s|
  s.name = 'dynarex-xslt'
  s.version = '0.1.7'
  s.summary = 'dynarex-xslt'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb'] 
  s.signing_key = '../privatekeys/dynarex-xslt.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/dynarex-xslt'
  s.required_ruby_version = '>= 2.1.2'
end
