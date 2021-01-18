transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/mtodorov/Documents/Internship_exercises/4.FIFO {/home/mtodorov/Documents/Internship_exercises/4.FIFO/FIFO.v}
vlog -vlog01compat -work work +incdir+/home/mtodorov/Documents/Internship_exercises/4.FIFO {/home/mtodorov/Documents/Internship_exercises/4.FIFO/testbench.v}

