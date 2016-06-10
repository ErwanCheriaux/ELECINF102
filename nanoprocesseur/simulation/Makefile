
.PHONY : clean all

# répertoire des fichiers source
vpath %.sv ../src 
vpath %.sv ./tb
vpath %.svp ./tb


SRC_FILES  =  $(FILES)
TAGS       = $(patsubst %.sv,.%.tag,$(SRC_FILES))
TAGS       += $(patsubst %.svp,.%.tag,$(SRC_FILES))

# règle par défaut
all : simu
	echo $(TAGS)

simu: $(TAGS) | work
	cp ../assembleur/verif.lst ../assembleur/ram.lst
	vsim -gui simu -do simu.do

work : 
	-vlib work

.%.tag: %.sv |work
	vlog +acc $<
	@touch $@	

.%.tag: %.svp |work
	vlog +acc $<
	@touch $@	


simu_pc: $(TAGS) | work
	vsim -gui simu_pc -do simu_pc.do

simu_alu: $(TAGS) | work
	vsim -c simu_alu -do simu_alu.do

# nettoyage 
clean : 
	rm -rf work *~
	rm -f transcript vsim.wlf .*.tag

