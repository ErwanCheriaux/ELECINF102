onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label {sclk (horloge)} /simu/sclk
add wave -noupdate -label {reset_n (reset, actif bas)} /simu/reset_n
add wave -noupdate -divider {vers la RAM}
add wave -noupdate -label ram_addr -radix hexadecimal /simu/proc1/ram_addr
add wave -noupdate -label ram_write /simu/proc1/ram_write
add wave -noupdate -label {accu (vers la RAM)} -radix hexadecimal /simu/mem1/data_in
add wave -noupdate -label {data venant de la RAM} -radix hexadecimal /simu/mem1/data_out
add wave -noupdate -divider Haut-parleur
add wave -noupdate -label out /simu/out
add wave -noupdate -divider {Registres processeur}
add wave -noupdate -label {I (instruction, en textuel)} -radix ascii /simu/disass/chaine
add wave -noupdate -label {I (instruction)} -radix decimal /simu/proc1/I
add wave -noupdate -label {PC (Program Counter)} -radix hexadecimal /simu/proc1/PC
add wave -noupdate -label {accu (accumulateur)} -radix hexadecimal /simu/proc1/accu
add wave -noupdate -divider ALU
add wave -noupdate -label {accu (operande 1)} -radix hexadecimal /simu/proc1/ALU/A
add wave -noupdate -label {ram_data (operande 2)} -radix hexadecimal /simu/proc1/ALU/B
add wave -noupdate -label {C_in (retenue entrante)} /simu/proc1/ALU/Cin
add wave -noupdate -label ALU_out -radix hexadecimal /simu/proc1/ALU/S
add wave -noupdate -label C_out /simu/proc1/ALU/Cout
add wave -noupdate -label Z_out /simu/proc1/ALU/Z
add wave -noupdate -divider CTR
add wave -noupdate -label {I (instruction)} -radix hexadecimal /simu/proc1/CTR/I
add wave -noupdate -label Z /simu/proc1/CTR/Z
add wave -noupdate -label C /simu/proc1/CTR/C
add wave -noupdate -label load_ACC /simu/proc1/CTR/load_ACC
add wave -noupdate -label load_OUT /simu/proc1/CTR/load_OUT
add wave -noupdate -label load_I /simu/proc1/CTR/load_I
add wave -noupdate -label load_AD /simu/proc1/CTR/load_AD
add wave -noupdate -label inc_PC /simu/proc1/CTR/inc_PC
add wave -noupdate -label load_PC /simu/proc1/CTR/load_PC
add wave -noupdate -label sel_adr /simu/proc1/CTR/sel_adr
add wave -noupdate -label write /simu/proc1/CTR/write
#add wave -noupdate -label cycle /simu/proc1/CTR/cycle
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {144 ns} 0}
configure wave -namecolwidth 190
configure wave -valuecolwidth 60
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {2520 ns}
run 2500ns
dataset open simu_nano_ref.wlf simu_nano_ref
compare start simu_nano_ref sim
compare options -track
compare add -recursive -all -wave *
compare run
