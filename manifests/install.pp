# Class: elasticsearch::install
#
#
class elasticsearch::install {
	common::archive { "elasticsearch-${elasticsearch::params::version}":
		ensure   => present,
		checksum => false,
		url      => "http://cloud.github.com/downloads/elasticsearch/elasticsearch/elasticsearch-${elasticsearch::params::version}.tar.gz",
		timeout  => 600,
		target   => $elasticsearch::params::unpack_root,
	}
	
	file { $elasticsearch::params::home_dir:
		ensure  => link,
		target  => $elasticsearch::params::install_dir,
		require => Common::Archive["elasticsearch-${elasticsearch::params::version}"],
	}
	
	git::clone { 'elasticsearch-servicewrapper':
		source    => 'git://github.com/elasticsearch/elasticsearch-servicewrapper.git',
		localtree => "${elasticsearch::params::unpack_root}",
		require   => File[$elasticsearch::params::home_dir],
	}
	
	file { "${elasticsearch::params::home_dir}/bin/service":
		ensure  => link,
		target  => "${elasticsearch::params::unpack_root}/elasticsearch-servicewrapper/service",
		require => Git::Clone['elasticsearch-servicewrapper'],
	}
	
	file { '/etc/init.d/elasticsearch':
		ensure  => link,
		target  => "${elasticsearch::params::home_dir}/bin/service/elasticsearch",
		require => File["${elasticsearch::params::home_dir}/bin/service"],
	}
}
