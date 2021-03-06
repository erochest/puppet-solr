
class solr::install {
  $mirror  = $solr::apache_mirror
  $version = $solr::version
  $tmpfile = '/tmp/apache-solr.tgz'

  package { 'tomcat7' :
    ensure => installed,
  }

  package { 'tomcat7-admin' :
    ensure => installed,
  }

  package { 'curl':
    ensure => installed,
  }

  exec { "curl > $tmpfile" : 
    command => "curl -o $tmpfile $mirror/lucene/solr/$version/solr-$version.tgz",
    path    => ['/usr/bin'],
    cwd     => '/tmp',
    creates => $tmpfile,
    require => Package['curl'],
  }

  exec { "tar xfz $tmpfile" :
    command => "tar xfz $tmpfile",
    path    => ['/bin', '/usr/bin'],
    cwd     => '/tmp',
    require => Exec["curl > $tmpfile"],
  }

  file { '/var/lib/tomcat7/webapps/solr.war' :
    source  => "/tmp/solr-$version/dist/solr-$version.war",
    require => Exec["tar xfz $tmpfile"],
    notify  => Service['tomcat7'],
  }

}

