plan mirror_users (
  String[1] $source,
  TargetSpec $nodes,
  Boolean $plan_noop = false,
) {
  # Query PuppetDB
  $groups = puppetdb_query("resources{ certname = '${source}' and type = 'Group' }")
  $users  = puppetdb_query("resources{ certname = '${source}' and type = 'User' }")
  $keys   = puppetdb_query("resources{ certname = '${source}' and type = 'Ssh_authorized_key' }")

  # Reformat data to be used by create_resources()
  [$groups, $users, $keys].each |$dataset| {
    $resource_type = $dataset[0]['type'].downcase
    $create_resources_hash = $dataset.reduce ( {} ) |$memo, $resource| {
      $memo + { $resource['title'] => $resource['parameters'] }
    }

    $result = run_task('mirror_users::create_things', $nodes, {
      type      => $resource_type,
      data      => $create_resources_hash,
      plan_noop => $plan_noop,
    })

    notice($result)
  }
}

