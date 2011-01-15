# Class: elasticsearch::install
#
#
class elasticsearch::install {
	common::archive { "elasticsearch-${es_version}":
		ensure   => present,
		checksum => false,
		url      => "http://cloud.github.com/downloads/elasticsearch/elasticsearch/elasticsearch-${es_version}.tar.gz",
		timeout  => 600,
		target   => "$es_unpack_root"
	}
	
	file { $es_home_dir:
		ensure  => link,
		target  => $es_install_dir,
		require => Common::Archive["elasticsearch-${es_version}"]
	}
	
	git::clone { "elasticsearch-servicewrapper":
		source    => "git://github.com/elasticsearch/elasticsearch-servicewrapper.git",
		localtree => "${es_unpack_root}",
		require   => File[$es_home_dir]
	}
	
	file { "${es_home_dir}/bin/service":
		ensure  => link,
		target  => "${es_unpack_root}/elasticsearch-servicewrapper/service",
		require => Git::Clone["elasticsearch-servicewrapper"]
	}
	
	file { "/etc/init.d/elasticsearch":
		ensure  => link,
		target  => "${es_home_dir}/bin/service/elasticsearch",
		require => File["${es_home_dir}/bin/service"]
	}
}
