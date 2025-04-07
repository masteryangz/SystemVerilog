transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM/ip_core {C:/Users/yangz/Desktop/SystemVerilog/ROM/ip_core/rom_256x8.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM {C:/Users/yangz/Desktop/SystemVerilog/ROM/rom.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM {C:/Users/yangz/Desktop/SystemVerilog/ROM/rom_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM {C:/Users/yangz/Desktop/SystemVerilog/ROM/key_filter.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM {C:/Users/yangz/Desktop/SystemVerilog/ROM/seg_595_dynamic.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM {C:/Users/yangz/Desktop/SystemVerilog/ROM/seg_dynamic.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM {C:/Users/yangz/Desktop/SystemVerilog/ROM/bcd_8421.v}
vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM {C:/Users/yangz/Desktop/SystemVerilog/ROM/hc595_ctrl.v}

vlog -vlog01compat -work work +incdir+C:/Users/yangz/Desktop/SystemVerilog/ROM {C:/Users/yangz/Desktop/SystemVerilog/ROM/tb_rom.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_rom

add wave *
view structure
view signals
run -all
