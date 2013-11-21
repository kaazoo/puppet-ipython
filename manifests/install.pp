class ipython::install {

  package { ["python${ipython::python_version}", "python${ipython::python_version}-dev", "git-core", "python-pymongo"]:
    ensure => present,
  }

  if ($operatingsystem == "Ubuntu") and ($operatingsystemrelease > 12) {
    package { "python-zmq":
      ensure => present,
    }
  }

  if ($operatingsystem == "Ubuntu") and ($operatingsystemrelease < 12) {
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

  # run install via pip
  if $ipython::install_method == 'pip' {

    package { 'python-pip':
      ensure => present,
    }

    include ipython::pip_install

  # run install via git
  } elsif $ipython::install_method == 'git' {

    include include::git_install

  } else {
    print('not supported install method')
  }

}
