
class solr::config {
  $version   = $solr::version
  $user      = $solr::tomcat_user
  $passwd    = $solr::tomcat_passwd
  $solr_home = $solr::solr_home
  $solr_core = $solr::solr_core

  file { 'tomcat-users.xml' :
    path    => '/etc/tomcat7/tomcat-users.xml',
    content => template('solr/tomcat-users.xml.erb'),
    notify  => Service['tomcat7'],
  }

  file { 'context.xml' :
    path    => '/etc/tomcat7/Catalina/localhost/solr.xml',
    content => template('solr/context.xml.erb'),
    require => Class['solr::install'],
    notify  => Service['tomcat7'],
  }

  file { 'Solr home directory' :
    path   => $solr_home,
    ensure => directory,
    owner  => 'tomcat7',
    group  => 'tomcat7',
  }

  file { 'solr.xml' :
    path    => "$solr_home/solr.xml",
    content => template('solr/solr.xml.erb'),
    owner   => 'tomcat7',
    group   => 'tomcat7',
    require => File['Solr home directory'],
  }

  file { 'Solr core directory' :
    path   => "$solr_home/$solr_core",
    ensure => directory,
    owner  => 'tomcat7',
    group  => 'tomcat7',
    require => File['Solr home directory'],
  }

  file { 'Solr conf directory' :
    path    => "$solr_home/$solr_core/conf",
    source  => "/tmp/solr-$version/example/solr/collection1/conf",
    recurse => true,
    owner   => 'tomcat7',
    group   => 'tomcat7',
    require => File['Solr core directory'],
  }

}

