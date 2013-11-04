class ipython ($git_branch = 'master', $git_tag = '', $python_version = '2.7') {
  include ipython::config, ipython::install, ipython::functions
}
