#!/opt/puppetlabs/puppet/bin/ruby
require 'json'

params = JSON.parse(STDIN.read)

extra_args = '--color=false'

if params['_noop']
  extra_args << ' --noop'
elsif params['plan_noop']
  extra_args << ' --noop'
end

command_line = [
  '/usr/local/bin/puppet',
  'apply',
  '-e',
  "\"#{params['type']}{",
  "'#{params['title']}':",
]

params['parameters'].each do |k, v|
  val = if v.is_a? String
          "'#{v}'"
        else
          v
        end

  command_line.push("#{k} => #{val},")
end
command_line.push('}"')
command_line.push(extra_args)

system(command_line.join(' '))
