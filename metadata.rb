name             'puma'
maintainer       'Yousef Ourabi'
maintainer_email 'yourabi@gmail.com'
license          'Apache v2.0'
description      'Installs and configures puma'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.4'

recipe           "puma", "Install puma"

depends          'monit'
depends          'logrotate'

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute "puma/version",
  :display_name => "Puma Version",
  :description => "Puma Version to install",
  :default => "2.0.1"

attribute "puma/bundler_version",
  :display_name => "Bundler Version",
  :description => "Bundler Version to install",
  :default => "1.3.5"
