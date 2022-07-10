onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb_multiplicador_ab/dut/A
add wave -noupdate -radix decimal /tb_multiplicador_ab/dut/B
add wave -noupdate -radix decimal /tb_multiplicador_ab/dut/R
add wave -noupdate /tb_multiplicador_ab/dut/factor_1
add wave -noupdate /tb_multiplicador_ab/dut/factor_2
add wave -noupdate /tb_multiplicador_ab/dut/factor_3
add wave -noupdate /tb_multiplicador_ab/dut/factor_4
add wave -noupdate /tb_multiplicador_ab/dut/A_aux
add wave -noupdate /tb_multiplicador_ab/dut/B_aux
add wave -noupdate /tb_multiplicador_ab/dut/R_aux
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {93176 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {682398 ps}
