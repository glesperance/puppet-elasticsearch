# Class: elasticsearch::config
#
#
class elasticsearch::config {
	file { [$elasticsearch::params::log_dir, $elasticsearch::params::data_dir, $elasticsearch::params::work_dir]:
		ensure  => directory,
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		notify  => Class['elasticsearch::service'],
		require => Class['elasticsearch::install'],
	}
	
	if $elasticsearch::params::config_dir_src != undef {
	   
    file { "${elasticsearch::params::config_dir}":
      ensure  => directory,
      source  => "${elasticsearch::params::config_dir_src}",
      recurse => inf,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Class['elasticsearch::service'],
      require => [ Class['elasticsearch::install'], File[$elasticsearch::params::config_dir] ],
    }
	
	} else {
	
  	file { "${elasticsearch::params::config_dir}/elasticsearch.yml":
  		ensure  => present,
  		source  => 'puppet:///modules/elasticsearch/elasticsearch.yml',
  		owner   => 'root',
  		group   => 'root',
  		mode    => '0644',
  		notify  => Class['elasticsearch::service'],
  		require => [ Class['elasticsearch::install'], File[$elasticsearch::params::config_dir] ],
  	}
  	
 }
	
	file { "${elasticsearch::params::home_dir}/bin/service/elasticsearch.conf":
		ensure  => present,
		content => template('elasticsearch/es-servicewrapper.conf.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		notify  => Class['elasticsearch::service'],
		require => Class['elasticsearch::install'],
	}
}
