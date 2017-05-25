set_device \
    -fam SmartFusion2 \
    -die PA4M7500_TS \
    -pkg fg484
set_input_cfg \
	-path {E:/LiberoProjects/CertificationSystem_M2S090TS/component/work/CertificationSystem_sb_MSS/ENVM.cfg}
set_output_efc \
    -path {E:\LiberoProjects\CertificationSystem_M2S090TS\designer\CertificationSystem\CertificationSystem.efc}
set_proj_dir \
    -path {E:\LiberoProjects\CertificationSystem_M2S090TS}
gen_prg -use_init false
