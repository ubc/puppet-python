# == Class: python
#
# Installs and manages python, python-dev, python-virtualenv and Gunicorn.
#
# === Parameters
#
# [*version*]
#  Python version to install. Default: system default
#
# [*pip*]
#  Install python-pip. Default: false
#
# [*dev*]
#  Install python-dev. Default: false
#
# [*virtualenv*]
#  Install python-virtualenv. Default: false, also accepts 'pip' which will
#  install latest virtualenv from pip rather than package manager
#
# [*gunicorn*]
#  Install Gunicorn. Default: false
#
# [*manage_gunicorn*]
#  Allow Installation / Removal of Gunicorn. Default: true
#
# === Examples
#
# class { 'python':
#   version    => 'system',
#   pip        => true,
#   dev        => true,
#   virtualenv => true,
#   gunicorn   => true,
#   uwsgi      => true,
# }
#
# === Authors
#
# Sergey Stankevich
#
class python (
  $version         = 'system',
  $pip             = false,
  $dev             = false,
  $virtualenv      = false,
  $gunicorn        = false,
  $manage_gunicorn = true,
  $provider        = undef,
  $uwsgi           = false,
  $uwsgi_cfg       = undef,
  $uwsgi_owner     = nginx,
) {

  # Module compatibility check
  $compatible = [ 'Debian', 'RedHat']
  if ! ($::osfamily in $compatible) {
    fail("Module is not compatible with ${::operatingsystem}")
  }

  Class['python::install'] -> Class['python::config']

  include python::install
  include python::config

}
