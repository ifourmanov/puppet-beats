# Setup the official repo
class beats::repo::apt() {
  apt::source { 'elastic-beats':
    comment  => 'Official Elastic beats repositories',
    location => 'https://artifacts.elastic.co/packages/5.x/apt',
    release  => 'stable',
    repos    => 'main',
    key      => {
      id     => 'D88E42B4',
      server => 'pgp.mit.edu'
    },
    include  => {
      'deb'  => true
    }
  }
  exec {'apt-get update':
    command => 'apt-get -qq update',
    path => '/usr/bin',
    unless => ['/usr/bin/dpkg -l | /bin/grep apt-transport-https']
  }
  package {'apt-transport-https':
    ensure  => latest,
    before  => Apt::Source['elastic-beats'],
    require => Exec['apt-get update']
  }
}
