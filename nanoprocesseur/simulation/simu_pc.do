onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -label clk /simu_pc/clk
add wave -noupdate -format Logic -label reset_n /simu_pc/reset_n
add wave -noupdate -divider .
add wave -noupdate -format Logic -label inc_PC /simu_pc/inc_PC
add wave -noupdate -format Logic -label load_PC /simu_pc/load_PC
add wave -noupdate -format Literal -label data_in -radix hexadecimal /simu_pc/data_in
add wave -noupdate -divider .
add wave -noupdate -format Literal -label PC -radix hexadecimal /simu_pc/PC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ns} {25 ns}
run 24

