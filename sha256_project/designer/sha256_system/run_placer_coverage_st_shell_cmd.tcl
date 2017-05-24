read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {D:/LiberoProjects/sha256_project/designer/sha256_system/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {D:\LiberoProjects\sha256_project\designer\sha256_system\sha256_system_place_and_route_constraint_coverage.xml}]
set reportfile {D:\LiberoProjects\sha256_project\designer\sha256_system\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp
