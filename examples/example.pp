class { 'facter_conf':
  facts_blocklist          => ['file system', 'EC2', 'os.architecture'],
  facts_ttls               => [
    { 'timezone' => '30 days' },
  ],
  global_external_dir      => ['path1', 'path2'],
  global_custom_dir        => ['custom/path'],
  global_no_external_facts => false,
  global_no_custom_facts   => false,
  global_no_ruby           => false,
  cli_debug                => false,
  cli_trace                => true,
  cli_verbose              => false,
  cli_log_level            => 'warn',
  fact_groups              => [
    {
      name  => 'custom-group-name',
      facts => ['os.name','ssh'],
    }
  ],
}
