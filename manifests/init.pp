import "classes/*.pp"
# Class: elasticsearch
#
#
class elasticsearch {
	if !$es_version { $es_version = "0.14.1" }
	if !$es_unpack_root { $es_unpack_root = "/opt" }
	if !$es_config_dir { $es_config_dir = "/etc/elasticsearch" }
	if !$es_log_dir { $es_log_dir = "/var/log/elasticsearch" }
	if !$es_data_dir { $es_data_dir = "/var/lib/elasticsearch" }
	if !$es_work_dir { $es_work_dir = "/tmp/elasticsearch" }
	$es_home_dir = "${es_unpack_root}/elasticsearch"
	$es_install_dir = "${es_unpack_root}/elasticsearch-${es_version}"
	
	# Some tuning variables
	if !$es_min_mem { $es_min_mem = "256" }
	if !$es_max_mem { $es_max_mem = "1024" }
	
	case $operatingsystem {
		/(?i)(Debian|Ubuntu)/: {
			$java_class = "java::openjdk::jre6headless"
		}
		/(?i)(Redhat|CentOS)/: {
			$java_class = "java::openjdk::jdk6"
		}
		default: {
			fail "Unsupported OS ${operatingsystem} in 'elasticsearch' module"
		}
	}
	
	include "${java_class}", elasticsearch::install, elasticsearch::config, elasticsearch::service
}
