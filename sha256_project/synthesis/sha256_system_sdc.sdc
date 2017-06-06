# Written by Synplify Pro version mapact, Build 1659R. Synopsys Run ID: sid1496695760 
# Top Level Design Parameters 

# Clocks 
create_clock -period 10.000 -waveform {0.000 5.000} -name {sha256_system_sb_CCC_0_FCCC|GL0_net_inferred_clock} [get_pins {sha256_system_sb_0/CCC_0/CCC_INST:GL0}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {sha256_controller|state_inferred_clock[1]} [get_pins {SHA256_BLOCK_0/sha256_controller_0/state[1]:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {sha256_controller|state_inferred_clock[4]} [get_pins {SHA256_BLOCK_0/sha256_controller_0/state[4]:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {reg_16x32|ren_pos_inferred_clock} [get_pins {SHA256_BLOCK_0/reg_16x32_0/ren_pos:Q}] 

# Virtual Clocks 

# Generated Clocks 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set Inferred_clkgroup_3 [list reg_16x32|ren_pos_inferred_clock]
set Inferred_clkgroup_1 [list sha256_controller|state_inferred_clock\[1\]]
set Inferred_clkgroup_2 [list sha256_controller|state_inferred_clock\[4\]]
set Inferred_clkgroup_0 [list sha256_system_sb_CCC_0_FCCC|GL0_net_inferred_clock]
set_clock_groups -asynchronous -group $Inferred_clkgroup_3
set_clock_groups -asynchronous -group $Inferred_clkgroup_1
set_clock_groups -asynchronous -group $Inferred_clkgroup_2
set_clock_groups -asynchronous -group $Inferred_clkgroup_0


# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

