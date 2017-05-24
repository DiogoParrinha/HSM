set_device -fam SmartFusion2
read_edif  \
    -file {D:\LiberoProjects\sha256_project\synthesis\sha256_system.edn}
write_vhdl -file {D:\LiberoProjects\sha256_project\synthesis\sha256_system.vhd}
