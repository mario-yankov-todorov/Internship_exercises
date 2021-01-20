transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/mtodorov/Documents/Internship_exercises/5.Memory_driver {/home/mtodorov/Documents/Internship_exercises/5.Memory_driver/memory_driver.v}
vlog -vlog01compat -work work +incdir+/home/mtodorov/Documents/Internship_exercises/5.Memory_driver {/home/mtodorov/Documents/Internship_exercises/5.Memory_driver/testbench.v}
vlog -vlog01compat -work work +incdir+/home/mtodorov/Documents/Internship_exercises/5.Memory_driver {/home/mtodorov/Documents/Internship_exercises/5.Memory_driver/button_counter.v}

vlog -vlog01compat -work work +incdir+/home/mtodorov/Documents/Internship_exercises/5.Memory_driver {/home/mtodorov/Documents/Internship_exercises/5.Memory_driver/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
