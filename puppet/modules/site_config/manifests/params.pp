class site_config::params {

  $ip_address               = hiera('ip_address')
  $ip_address_interface     = getvar("interface_${ip_address}")
  $ec2_local_ipv4_interface = getvar("interface_${::ec2_local_ipv4}")

  if $::virtual == 'virtualbox' {
    $interface = [ 'eth0', 'eth1' ]
  }
  elsif hiera('interface','') != '' {
    $interface = hiera('interface')
  }
  elsif $ip_address_interface != '' {
    $interface = $ip_address_interface
  }
  elsif $ec2_local_ipv4_interface != '' {
    $interface = $ec2_local_ipv4_interface
  }
  elsif $::interfaces =~ /eth0/ {
    $interface = eth0
  }
  else {
    fail("unable to determine a valid interface, please set a valid interface for this node in nodes/${::hostname}.json")
  }
}
