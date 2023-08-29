# facter_conf

A Puppet module that is used to configure ```facter.conf```.

For more information, please refer to [Configuring Facter with facter.conf][1]

## Table of Contents

1. [Description](#description)
1. [Setup](#setup)
    * [Beginning with facter_conf](#beginning-with-facter_conf)
1. [Usage](#usage)
1. [Limitations](#limitations)
1. [Development](#development)

## Description

facter_conf is a module for easily configuring Facter to set how it interacts with a system, configure fact caching, fact groups and facts/fact groups to block. 

## Setup

### Beginning with facter_conf

By default, facter_conf will simply create an empty ```facter.conf``` file.

```puppet
include facter_conf
```

## Usage

facter_conf supports the use of Hiera data for setting parameters.  Please refer to [REFERENCE][2] for a list of configurable parameters. 

### Configure fact caching

```yaml
---
facter_conf::facts_ttls:
  - timezone: '30 days'
  - os: '1 hour'
```

### Configure fact caching for a custom fact group

```yaml
---
facter_conf::facts_ttls:
  - custom_fact_group: '30 days'
facter_conf::fact_groups:
  - name: 'custom_fact_group'
    facts:
      - 'os.name'
      - 'ec2_metadata'
```

### Configuring all sections of facter.conf

```yaml
facter_conf::facts_blocklist: 
  - 'file system'
  - 'EC2' 
  - 'os.architecture'
facter_conf::facts_ttls:
  - timezone: '30 days'
  - os: '30 days'
facter_conf::global_external_dir:
  - 'path1'
  - 'path2'
facter_conf::global_custom_dir:
  - 'custom/path'
facter_conf::global_no_external_facts: false
facter_conf::global_no_custom_facts: false
facter_conf::global_no_ruby: false
facter_conf::cli_debug: false
facter_conf::cli_trace: true
facter_conf::cli_verbose: false
facter_conf::cli_log_level: 'warn'
facter_conf::fact_groups:
  - name: 'custom_fact_group'
    facts:
      - 'os.name'
      - 'ssh'
```

The same configuration can be done as a class declaration as follows:

```puppet
  class { 'facter_conf':
    facts_blocklist          => ['file system', 'EC2', 'os.architecture'],
    facts_ttls               => [
      { 'timezone' => '30 days' },
      { 'os' => '30 days' },
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
```

## Limitations

This module has only been tested with Facter 4.3.1

## Development

If you would like to contribute with the development of this module, please feel free to log development changes in the [issues][3] register for this project

[1]: https://www.puppet.com/docs/puppet/latest/configuring_facter.html
[2]: https://forge.puppet.com/modules/jortencio/facter_conf/reference
[3]: https://github.com/jortencio/facter_conf/issues
