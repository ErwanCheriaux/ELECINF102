
#PROJECT = nano
export TOP = DE1_SoC
# Répertoire courant
export TOP_DIR = $(shell pwd)

# répertoire des fichiers source
vpath %.sv $(TOP_DIR)/src

COMMON_FILES = nanoprocesseur.sv ram.sv
CTR_FILE     = ctr.sv
PC_FILE      = pc.sv
ALU_FILE     = alu.sv

export SYNTHESE_FILES = $(COMMON_FILES) gene_clk.sv gene_reset.sv $(TOP).sv

MAKE_CMD = make
.PHONY : clean all verif chicken simu simu_pc simu_alu compile_pc compile_alu compile_ctr prg_verif prg_chicken

# règle par défaut
all : help

help :
	@echo "Liste des commandes possibles:"
	@echo " make compile_pc  : pour vérifier la syntax du PC"
	@echo " make compile_alu : pour vérifier la syntax de l'ALU"
	@echo " make compile_ctr : pour vérifier la syntax du controleur"
	@echo " make simu_pc     : pour simuler le PC"
	@echo " make simu_alu    : pour simuler l'ALU"
	@echo " make simu        : pour simuler le processeur globalement"
	@echo " make chicken     : pour synthétiser le programme musical"
	@echo " make prg_chicken : pour programmer le FPGA avec le programme musical"
	@echo " make verif       : pour synthétiser le test global"
	@echo " make prg_verif   : pour programmer le FPGA avec le test global"


compile_pc:
	$(MAKE_CMD) -C simulation .pc.tag

compile_alu:
	$(MAKE_CMD) -C simulation .alu.tag

compile_ctr:
	$(MAKE_CMD) -C simulation .ctr.tag

verif :
	$(MAKE_CMD) -C syn verif

chicken :
	$(MAKE_CMD) -C syn chicken


simu:
	$(MAKE_CMD) -C simulation "FILES = $(COMMON_FILES) $(PC_FILE) $(CTR_FILE) $(ALU_FILE) disass.sv simu.sv"

simu_pc:
	$(MAKE_CMD) -C simulation "FILES = $(PC_FILE) simu_pc.sv" simu_pc

simu_alu:
	$(MAKE_CMD) -C simulation "FILES = $(ALU_FILE) simu_alu.svp" simu_alu

clean :
	$(MAKE_CMD) -C simulation clean
	$(MAKE_CMD) -C syn clean
	-rm -f *~ assembleur/ram.lst

prg_verif :
	$(MAKE_CMD) -C syn prg_verif

prg_chicken :
	$(MAKE_CMD) -C syn prg_chicken
