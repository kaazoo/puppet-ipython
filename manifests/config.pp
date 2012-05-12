class ipython::config {
  
  package { ["python${ipython::python_version}", "python${ipython::python_version}-dev", "git-core"]:
    ensure => present,
  }

  file { "/etc/apt/sources.list.d/chris-lea-zeromq-oneiric.list":
    ensure => present,
    content => "deb http://ppa.launchpad.net/chris-lea/zeromq/ubuntu oneiric main",
    notify => Exec["aptitude update"],
    alias => "ppa-zeromq",
  }

  exec { "aptitude update":
    command => "/usr/bin/aptitude update",
    refreshonly => true,
  }

  package { "libzmq-dev":
    ensure => present,
    require => File["ppa-zeromq"],
  }


}
