class ipython::git_install {

  search Ipython::Functions

  # clone repository & checkout tag if specified
  if $ipython::git_tag != '' {
    exec { "git clone git://github.com/ipython/ipython.git && cd /root/ipython && git checkout ${ipython::git_tag}":
      cwd     => '/root',
      creates => '/root/ipython',
      path    => ['/bin', '/usr/bin', '/usr/sbin'],
      require => Package['git-core'],
      notify  => Exec['ipython-install'],
    }
  } else {
    # clone repository & switch to specific branch
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
