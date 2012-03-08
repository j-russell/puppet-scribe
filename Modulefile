name 'jrussell-scribe'
version '0.0.1'

author 'Josh Russell'
license ''
project_page ''
source ''
summary 'Module to manage scribe and related config'
description 'A puppet module to install and configure scribe. This modules assumes you have your own scribe rpm built.

The store configuration can be specified using a puppet hash structure:
  $stores = {
      \'default\'      => {
        \'type\'                 => \'file\',
        \'target_write_size\'    => 20480,
        \'max_write_interval\'   => 1,
        \'buffer_send_rate\'     => 5,
        \'retry_interval\'       => 30,
        \'retry_interval_range\' => 10,
        \'fs_type\'              => \'std\',
        \'file_path\'            => \'/u01/scribe/logs\',
        \'base_filename\'        => \'thisisoverwritten\',
        \'add_newlines\'         => 0,
        \'rotate_period\'        => \'1m\',
      },
      \'buffer_store\' => {
        \'type\'                 => \'buffer\',
        \'target_write_size\'    => 20480,
        \'max_write_interval\'   => 1,
        \'buffer_send_rate\'     => 5,
        \'retry_interval\'       => 30,
        \'retry_interval_range\' => 10,
        \'primary\'   => {
          \'type\'        => \'network\',
          \'remote_host\' => \'scribemaster\',
          \'remote_port\' => 1463,
        },
        \'secondary\' => {
          \'type\'          => \'file\',
          \'fs_type\'       => \'std\',
          \'file_path\'     => \'/scribe/buffer\',
          \'base_filename\' => \'thisisoverwritten\',
          \'max_size\'      => 209715200,
        }
      }
    })

or a YAML hash structure:
  scribe_stores:
    default: 
      target_write_size: 20480
      base_filename: thisisoverwritten
      retry_interval_range: 10
      buffer_send_rate: 5
      max_write_interval: 1
      rotate_period: 1m
      file_path: /u01/scribe/logs
      fs_type: std
      add_newlines: 0
      type: file
      retry_interval: 30
    buffer_store: 
      type: buffer
      retry_interval: 30
      target_write_size: 20480
      buffer_send_rate: 5
      max_write_interval: 1
      retry_interval_range: 10
      primary: 
        remote_host: scribemaster
        remote_port: 1463
        type: network
      secondary:
        type: file 
        fs_type: std
        file_path: /scribe/buffer
        max_size: 209715200
        base_filename: thisisoverwritten'
        
dependency 'puppetlabs/hiera', '>=0.0.1'
dependency 'puppetlabs/hiera-puppet', '>=0.0.1'