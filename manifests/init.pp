  #== Class: scribe
  #
  #Scribe main class. Installs scribe package and configures scribe service and store configuration.
  #
  #=== Parameters
  #
  #[*package*]
  #  The name of the scribe package
  #  
  #  Default: scribe-server
  #
  #[*service*]
  #  The name of the scribe init script
  #  
  #  Default: scribed
  #
  #[*conf_dir*]
  #  The directory to store the scribe config file in
  #  
  #  Default: /etc/scribe
  #
  #[*conf_file*]
  #  The name of the scribe configuration file
  #  
  #  Default: basic.conf
  #  
  #[*port*]
  #  Which port the scribe server will listen on
  #  
  #  Default: 1463
  #  
  #[*max_msg_per_second*]
  #  User in scribe in scribeHandler::throttleDeny
  #  
  #  Default: 0
  #  
  #[*max_queue_size*]
  #  In bytes, used in scribe in scribeHandler::Log
  #  
  #  Default: 5,000,000 bytes
  #  
  #[*check_interval*]
  #  Used to control how often to check each store
  #  
  #  Default: 5
  #  
  #[*new_thread_per_category*]
  #  Yes/No
  #  
  #  If yes, will create a new thread for every category seen. Otherwise, will only create a single thread for every store defined in the configuration.
  #  
  #  For prefix stores or the default store, setting this parameter to ÒnoÓ will cause all messages that match this category to get processed by a single store. Otherwise, a new store will be created for each unique category name.
  #  
  #  Default: yes
  #  
  #[*num_thrift_server_threads*]
  #  Number of threads listening for incoming messages
  #  
  #  Default: 3
  #
  #=== Variables
  #
  #None
  #
  #=== Examples
  #
  #  class { 'scribe':
  #    $package                   => 'scribe-server',
  #    $service                   => 'scribed',
  #    $conf_dir                  => '/etc/scribe',
  #    $conf_file                 => 'basic.conf',
  #    $port                      => 1463,
  #    $max_msg_per_second        => 0,
  #    $max_queue_size            => 5000000,
  #    $check_interval            => 5,
  #    $new_thread_per_category   => 'yes',
  #    $num_thrift_server_threads => 3,
  #    
  #    $stores = {
  #      'default'     => {
  #        'type'                 => 'file',
  #        'target_write_size'    => 20480,
  #        'max_write_interval'   => 1,
  #        'buffer_send_rate'     => 5,
  #        'retry_interval'       => 30,
  #        'retry_interval_range' => 10,
  #        'fs_type'              => 'std',
  #        'file_path'            => '/scribe/buffer',
  #        'base_filename'        => 'thisisoverwritten',
  #        'add_newlines'         => 0,
  #        'rotate_period'        => '1m',
  #      },
  #      'buffer_store' => {
  #        'type'                 => 'buffer',
  #        'target_write_size'    => 20480,
  #        'max_write_interval'   => 1,
  #        'buffer_send_rate'     => 5,
  #        'retry_interval'       => 30,
  #        'retry_interval_range' => 10,
  #        'primary'  => {
  #          'type'        => 'network',
  #          'remote_host' => 'scribemaster',
  #          'remote_port' => 1463,
  #        },
  #        'secondary' => {
  #          'type'          => 'file',
  #          'fs_type'       => 'std',
  #          'file_path'     => '/scribe/buffer',
  #          'base_filename' => 'thisisoverwritten',
  #          'max_size'      => 209715200,
  #        }
  #      }
  #    },
  #  }
  #
  #=== Authors
  #
  #Josh Russell <josh.russell@jumptap.com>
  #
class scribe (
  $package                   = $scribe::data::package,
  $service                   = $scribe::data::service,
  $conf_dir                  = $scribe::data::conf_dir,
  $conf_file                 = $scribe::data::conf_file,
  $port                      = $scribe::data::port,
  $max_msg_per_second        = $scribe::data::max_msg_per_second,
  $max_queue_size            = $scribe::data::max_queue_size,
  $check_interval            = $scribe::data::check_interval,
  $new_thread_per_category   = $scribe::data::new_thread_per_category,
  $num_thrift_server_threads = $scribe::data::num_thrift_server_threads,
  $stores                    = $scribe::data::stores,
) inherits scribe::data {

  package { $scribe::data::package:
    ensure => installed,
  }
  
  service { $scribe::data::service:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package[$scribe::data::package],
  }

  file { "${scribe::data::conf_dir}/${scribe::data::conf_file}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("scribe/${scribe::data::conf_file}.erb"),
    require => Package[$scribe::data::package],
    notify  => Service[$scribe::data::service],
  }

}
