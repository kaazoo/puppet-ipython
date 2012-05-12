class ipython {
  $git_branch = "master"
  $python_version = "2.7"
  include ipython::config, ipython::install
}
