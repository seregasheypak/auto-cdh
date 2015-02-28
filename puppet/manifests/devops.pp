class devops_user {
  group { 'supergroup':
    ensure => present,
  }
  user { 'devops':
    ensure => present,
    groups => ['wheel', 'supergroup'],
    home => '/home/devops',
    managehome => true,
    password => '$6$W9Gbanls$8PVgpWzRhLV2YvcxBk7AqE7WXY.k.J7G48x82K7OTtK5IWeCZ8Ef05WDIm0eUdYLVj.FxEXr6o5VOSi8N5QVn.',
    require	=> Group['supergroup'],
  }
}
