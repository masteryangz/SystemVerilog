transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/pll {C:/Users/yangz/Desktop/SystemVerilog/pll/pll.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/pll/ipcore_dir {C:/Users/yangz/Desktop/SystemVerilog/pll/ipcore_dir/pll_ip.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/pll/db {C:/Users/yangz/Desktop/SystemVerilog/pll/db/pll_ip_altpll.v}

vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/pll {C:/Users/yangz/Desktop/SystemVerilog/pll/tb_pll.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_pll

add wave *
view structure
view signals
run -all
