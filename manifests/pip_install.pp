class ipython::pip_install {

  # install via pip
  exec { "pip install ipython==${ipython::ipython_version}":
    path    => ['/bin', '/usr/bin', '/usr/sbin'],
    require => Package["python${ipython::python_version}", "python${ipython::python_version}-dev", 'python-pip'],
    creates => "/usr/local/bin/ipython",
  }

}
