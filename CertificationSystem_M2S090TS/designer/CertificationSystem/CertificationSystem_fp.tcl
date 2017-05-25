new_project \
         -name {CertificationSystem} \
         -location {E:\LiberoProjects\CertificationSystem_M2S090TS\designer\CertificationSystem\CertificationSystem_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S090TS} \
         -name {M2S090TS}
enable_device \
         -name {M2S090TS} \
         -enable {TRUE}
save_project
close_project
