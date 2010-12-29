# Class: elasticsearch::install
#
#
class elasticsearch::install {
	include java::jre6headless
	
	common::archive { "elasticsearch-${es_version}":
	    ensure   => present,
		checksum => false,
	    url      => "http://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-0.14.0.tar.gz",
	    target   => "$es_unpack_root",
	  }
	
	file { $es_home_dir:
		ensure  => link,
		target  => $es_install_dir,
		require => Common::Archive["elasticsearch-${es_version}"]
	}
}
