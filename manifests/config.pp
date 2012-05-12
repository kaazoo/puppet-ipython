class ipython::config {
  
  package { ["python${ipython::python_version}", "python${ipython::python_version}-dev", "git-core"]:
    ensure => present,
  }

}
