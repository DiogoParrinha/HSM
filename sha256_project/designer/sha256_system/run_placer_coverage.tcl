set_family {SmartFusion2}
read_adl {E:\LiberoProjects\sha256_project\designer\sha256_system\sha256_system.adl}
map_netlist
check_constraints {E:\LiberoProjects\sha256_project\designer\sha256_system\placer_coverage.log}
write_sdc -strict {E:\LiberoProjects\sha256_project\designer\sha256_system\place_route.sdc}
