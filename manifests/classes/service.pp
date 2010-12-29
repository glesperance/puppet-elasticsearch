# Class: elasticsearch::service
#
#
class elasticsearch::service {
	service { "elasticsearch":
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => false,
		require    => Class["elasticsearch::config"]
	}
}
