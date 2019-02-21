#!/opt/puppetlabs/puppet/bin/ruby
require 'json'

params = JSON.parse(STDIN.read)
params['data'].each do |k, v|
  v.delete('require')
end

extra_args = '--color=false'

if params['_noop']
  extra_args << ' --noop'
elsif params['plan_noop']
  extra_args << ' --noop'
end

File.open("/tmp/boltcmd-#{params['type']}", 'w') { |file|
  file.write("create_resources(#{params['type']}, #{params['data']})")
}

command_line = [
  '/opt/puppetlabs/puppet/bin/puppet',
  'apply',
  "/tmp/boltcmd-#{params['type']}",
]
command_line.push(extra_args)
system(command_line.join(' '))
File.delete("/tmp/boltcmd-#{params['type']}")
