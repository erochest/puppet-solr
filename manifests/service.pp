
class solr::service {

  service { 'tomcat7' :
    ensure  => running,
    enable  => true,
    require => Class['solr::install'],
  }

}

