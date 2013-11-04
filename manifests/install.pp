class ipython::install {

  search Ipython::Functions

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

  # clone repository & checkout tag if specified
  if $ipython::git_tag != '' {
    exec { "git clone git checkout git://github.com/ipython/ipython.git && cd /root/ipython && git checkout ${ipython::git_tag}":
      cwd     => '/root',
      creates => '/root/ipython',
      path    => ['/bin', '/usr/bin', '/usr/sbin'],
      require => Package['git-core'],
      notify  => Exec['ipython-install'],
    }
  } else {
    # clone repository & switch to specific branch
    if $ipython::git_branch
    exec { "git clone -b ${ipython::git_branch} git://github.com/ipython/ipython.git":
      cwd     => '/root',
      creates => '/root/ipython',
      path    => ['/bin', '/usr/bin', '/usr/sbin'],
      require => Package['git-core'],
      notify  => Exec['ipython-install'],
    }
  }

  # install from cloned git repository
  pysetup_install { "ipython":
    cwd => "/root/ipython",
    reqs => Package["python${ipython::python_version}", "python${ipython::python_version}-dev"],
  }

}
