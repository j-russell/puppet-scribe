class scribe::data {
	
	$package 										= hiera('scribe_package','scribe-server')
	$service 										= hiera('scribe_service','scribed')
	$conf_dir 									= hiera('scribe_conf_dir','/etc/scribe')
	$conf_file 									= hiera('scribe_conf_file',"basic.conf")
	$port 											= hiera('scribe_port',1463)
	$max_msg_per_second 				= hiera('scribe_max_msg_per_second',0)
	$max_queue_size 						= hiera('scribe_max_queue_size',5000000)
	$check_interval 						= hiera('scribe_check_interval',5)
	$new_thread_per_category 		= hiera('scribe_new_thread_per_category','yes')
	$num_thrift_server_threads	= hiera('scribe_num_thrift_server_threads',3)
	
	$stores = hiera('scribe_stores',{
		'default' 		 => {
			'type'								 => 'file',
			'target_write_size' 	 => 20480,
			'max_write_interval' 	 => 1,
			'buffer_send_rate' 		 => 5,
			'retry_interval' 			 => 30,
			'retry_interval_range' => 10,
			'fs_type' 						 => 'std',
			'file_path' 					 => '/scribe/buffer',
			'base_filename' 			 => 'thisisoverwritten',
			'add_newlines' 				 => 0,
			'rotate_period' 			 => '1m',
		},
		'buffer_store' => {
			'type' 								 => 'buffer',
			'target_write_size' 	 => 20480,
			'max_write_interval' 	 => 1,
			'buffer_send_rate' 		 => 5,
			'retry_interval' 			 => 30,
			'retry_interval_range' => 10,
			'primary' 	=> {
				'type' 				=> 'network',
			  'remote_host' => 'scribemaster',
			  'remote_port' => 1463,
			},
			'secondary' => {
				'type' 					=> 'file',
				'fs_type' 			=> 'std',
				'file_path' 		=> '/scribe/buffer',
				'base_filename' => 'thisisoverwritten',
				'max_size' 			=> 209715200,
			}
		}
	})
	
}