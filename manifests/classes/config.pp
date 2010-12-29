# Class: elasticsearch::config
#
#
class elasticsearch::config {
	File {
		require => Class["elasticsearch::install"],
		notify  => Class["elasticsearch::service"],
		owner   => root,
		group   => root
	}
	
	file { "/etc/init.d/elasticsearch":
		ensure  => present,
		mode    => 755,
		content => template("elasticsearch/es-init.erb")
	}
	
	file { [$es_config_dir, $es_log_dir, $es_data_dir, $es_work_dir]:
		ensure => directory,
		mode   => 0755
	}
	
	file { "${es_config_dir}/elasticsearch.yml":
		ensure  => present,
		source  => "puppet:///modules/elasticsearch/elasticsearch.yml",
		require => File["${es_config_dir}"]
	}
}
