name "sam-app"
description "An application server for the SAM/SLMS software suite"
run_list(
	"role[centos-base]"
)
