new_project \
         -name {sha256_system} \
         -location {E:\LiberoProjects\sha256_project\designer\sha256_system\sha256_system_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S060} \
         -name {M2S060}
enable_device \
         -name {M2S060} \
         -enable {TRUE}
save_project
close_project
