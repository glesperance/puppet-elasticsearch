# Class: elasticsearch::install
#
#
class elasticsearch::install {
	include java::jre6headless
	
	common::archive { "elasticsearch-${es_version}.tar.gz":
	    ensure   => present,
		checksum => false,
	    url      => "http://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-${es_version}.tar.gz",
	    target   => "$es_unpack_root",
	  }
	
	file { $es_home_dir:
		ensure  => link,
		target  => $es_install_dir,
		require => Common::Archive["elasticsearch-${es_version}.tar.gz"]
	}
}
