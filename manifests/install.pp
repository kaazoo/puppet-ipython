class ipython::install {

  # clone from git repository
  exec { "git clone -b ${ipython::git_branch} git://github.com/ipython/ipython.git":
    cwd     => "/root",
    creates => "/root/ipython",
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
    require => Package["git-core"],
    notify  => Exec["ipython-install"],
  }

  # install from cloned git repository
  exec { "python${ipython::python_version} setup.py install":
    cwd         => "/root/ipython",
    path        => ["/bin", "/usr/bin", "/usr/sbin"],
    require     => Package["python${ipython::python_version}", "python${ipython::python_version}-dev"],
    refreshonly => true,
    alias       => "ipython-install",
  }

}
