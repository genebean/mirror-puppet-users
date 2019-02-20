src=$1
target=$2
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 source_fqdn target_fqdn"
  exit 1
fi
./get_json.sh $src
python puppet-resources-from-json.py > resources.pp
bolt file upload resources.pp /tmp/resources.pp -n $target
bolt command run 'sudo puppet apply /tmp/resources.pp' -n $target
bolt command run 'rm -f /tmp/resources.pp' -n $target

