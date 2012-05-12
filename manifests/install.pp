class ipython::install {

  search Ipython::Functions

  # clone from git repository
  exec { "git clone -b ${ipython::git_branch} git://github.com/ipython/ipython.git":
    cwd     => "/root",
    creates => "/root/ipython",
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
    require => Package["git-core"],
    notify  => Exec["ipython-install"],
  }

  # install from cloned git repository
  pysetup_install { "ipython":
    cwd => "/root/ipython",
    reqs => Package["python${ipython::python_version}", "python${ipython::python_version}-dev"],
  }

}
