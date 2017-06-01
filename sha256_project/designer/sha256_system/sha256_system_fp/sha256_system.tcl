open_project -project {E:\LiberoProjects\sha256_project\designer\sha256_system\sha256_system_fp\sha256_system.pro}
set_programming_file -name {M2S060} -file {E:\LiberoProjects\sha256_project\designer\sha256_system\sha256_system.ipd}
enable_device -name {M2S060} -enable 1
set_programming_action -action {PROGRAM} -name {M2S060} 
run_selected_actions
set_programming_file -name {M2S060} -no_file
save_project
close_project
