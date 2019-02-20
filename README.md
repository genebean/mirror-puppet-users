# mirror-puppet-users

Query PuppetDB for group, user, and ssh_authorized_key resources on a
particular server and then reproduce those resources on another server.

## Requirements

The nodes you wish to copy users to must have Puppet installed. It does not
have to be a current version though.

## Usage

Run a noop first to be safe:

```
$ bolt plan run mirror_users source=source.example.com plan_noop=true -n target.example.com --run-as root
```

If that all looks good run it for real:

```
$ bolt plan run mirror_users source=source.example.com -n target.example.com --run-as root
```

To see more details run `bolt plan show mirror_users`.

## Under the hood

Under the hood this is using a [Puppet Bolt plan][] to

1. query PuppetDB groups, users, and ssh keys on the given `source` node
2. running a task to create each resource via `puppet apply`

The code that makes this all work is `Boltdir/site/mirror_users` with plans and
tasks in their respective folders.


[Puppet Bolt plan]: https://puppet.com/docs/bolt/1.x/writing_tasks_and_plans.html
