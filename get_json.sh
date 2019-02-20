host=$1
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 some_fqdn"
  exit 1
fi

echo "Gathering resources from ${host}..."
puppet-query "resources{ type = 'Group' and certname = '${host}' }" > groups.json
puppet-query "resources{ type = 'User' and certname = '${host}' }" > users.json
puppet-query "resources{ type = 'Ssh_authorized_key' and certname = '${host}' }" > keys.json

