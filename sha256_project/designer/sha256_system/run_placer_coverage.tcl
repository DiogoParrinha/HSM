set_family {SmartFusion2}
read_adl {D:\LiberoProjects\sha256_project\designer\sha256_system\sha256_system.adl}
map_netlist
check_constraints {D:\LiberoProjects\sha256_project\designer\sha256_system\placer_coverage.log}
write_sdc -strict {D:\LiberoProjects\sha256_project\designer\sha256_system\place_route.sdc}
