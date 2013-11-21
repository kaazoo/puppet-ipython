class ipython ($install_method = 'pip', $ipython_version = '1.1.0', $git_branch = 'master', $git_tag = '', $python_version = '2.7') {
  include ipython::config, ipython::install, ipython::functions
}
