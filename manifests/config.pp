
class solr::config {
  $user   = $solr::tomcat_user
  $passwd = $solr::tomcat_passwd

  file { 'tomcat-users.xml' :
    path    => '/etc/tomcat7/tomcat-users.xml',
    content => template('solr/tomcat-users.xml.erb'),
    notify  => Service['tomcat7'],
  }

}

