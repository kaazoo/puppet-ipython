class ipython::functions {

  define pysetup_install($cwd, $reqs) {
    exec { "${name}-install":
      command     => "python${ipython::python_version} setup.py install",
      cwd         => $cwd,
      path        => ["/bin", "/usr/bin", "/usr/sbin"],
      require     => $reqs,
      refreshonly => true,
    }
  }


}