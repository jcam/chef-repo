name "centos-base"
description "Contains recipes common to all CentOS VMs"
run_list(
	"recipe[selinux::disabled]",
	"recipe[sudo]",
	"recipe[authconfig]"
)
default_attributes(
	:authconfig => {
	:ldap => {
	:auth => "true",
	:basedn => "dc=atl,dc=setg",
	:enable => "true",
	:rfc2307bis => "true",
	:server => "ldap://ldap.ops.atl.setg/"
}
},
	:sssd => {
	:insertlines => [
		{
	:insertpoint => "auth_provider = ldap",
	:text => "ldap_group_member = uniqueMember"
},
	{
	:insertpoint => "ldap_tls_cacertdir = /etc/openldap/cacerts",
	:text => "ldap_tls_reqcert = never"
}
]
},
	:authorization => {
	:sudo => {
	:groups => "hosting",
	:passwordless => "false",
	:users => [
		{
	:name => "autoadmin",
	:passwordless => "true"
},
	{
	:name => "syncmaster",
	:passwordless => "true"
}
]
}
}
)
