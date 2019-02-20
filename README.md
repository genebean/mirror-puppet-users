# mirror-puppet-users

Query PuppetDB for group, user, and ssh_authorized_key resources on a
particular server and then reproduce those resources on another server.

## Usage

Run a noop first to be safe:

```
$ ./noop.sh source.example.com target.example.com
```

If that all looks good run it for real:

```
$ ./make_it_so.sh source.example.com target.example.com
```

## Under the hood

Under the hood this is running the following:

- `puppet-query` to collect resources and save them into json files
- `puppet-resources-from-json.py` to generate a Puppet manifest
- `bolt upload` to place the manifest in `/tmp/` on the target
- `bolt command run` to apply the manifest
- `bolt command run` to clean up after itself

