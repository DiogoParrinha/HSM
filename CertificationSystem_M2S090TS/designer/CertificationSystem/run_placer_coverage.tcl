set_family {SmartFusion2}
read_adl {E:\LiberoProjects\CertificationSystem_M2S090TS\designer\CertificationSystem\CertificationSystem.adl}
map_netlist
check_constraints {E:\LiberoProjects\CertificationSystem_M2S090TS\designer\CertificationSystem\placer_coverage.log}
write_sdc -strict {E:\LiberoProjects\CertificationSystem_M2S090TS\designer\CertificationSystem\place_route.sdc}
