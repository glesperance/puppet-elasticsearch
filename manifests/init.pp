# Class: elasticsearch
#
#
class elasticsearch {
	require elasticsearch::params
	
	case $operatingsystem {
		/(?i)(Debian|Ubuntu)/: {
			$java_class = 'java::openjdk::jre6headless'
		}
		/(?i)(Redhat|CentOS)/: {
			$java_class = 'java::openjdk::jdk6'
		}
		default: {
			fail "Unsupported OS ${operatingsystem} in 'elasticsearch' module"
		}
	}
	
	include "${java_class}", elasticsearch::install, elasticsearch::config, elasticsearch::service
}
