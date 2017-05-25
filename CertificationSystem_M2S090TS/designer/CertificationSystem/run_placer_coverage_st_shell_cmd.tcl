read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {E:/LiberoProjects/CertificationSystem_M2S090TS/designer/CertificationSystem/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {E:\LiberoProjects\CertificationSystem_M2S090TS\designer\CertificationSystem\CertificationSystem_place_and_route_constraint_coverage.xml}]
set reportfile {E:\LiberoProjects\CertificationSystem_M2S090TS\designer\CertificationSystem\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp
