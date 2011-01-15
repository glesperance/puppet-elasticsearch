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
	
	file { [$es_config_dir, $es_log_dir, $es_data_dir, $es_work_dir]:
		ensure => directory,
		mode   => 0755
	}
	
	file { "${es_config_dir}/elasticsearch.yml":
		ensure  => present,
		source  => "puppet:///modules/elasticsearch/elasticsearch.yml",
		require => File["${es_config_dir}"]
	}
	
	file { "${es_home_dir}/bin/service/elasticsearch.conf":
		ensure  => present,
		content => template("elasticsearch/es-servicewrapper.conf.erb")
	}
}
