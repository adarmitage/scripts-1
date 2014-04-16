#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 16
<<<<<<< HEAD
#$ -l virtual_free=1G
=======
#$ -l virtual_free=0.9G
>>>>>>> 47c5dd194f9ad3148da3a0c95c057ea2bb1aa8f8
#$ -M andrew.armitage@emr.ac.uk
#$ -m abe



#######  Step 1	 ########
# Initialise values		#
#########################

CUR_PATH=$PWD
WORK_DIR=/tmp/path_pipe

SORTED_CONTIGS=$1
SIG_P=/home/master_files/prog_master/bin/signalp

ORGANISM=$(echo $SORTED_CONTIGS | cut -d "/" -f3)
STRAIN=$(echo $SORTED_CONTIGS | cut -d "/" -f4)

mkdir $WORK_DIR
cd $WORK_DIR


#######  Step 1	 ########
# Run RXLR part1		#
#########################

# RxLR pipeline- input your sorted contigs as your first argument and the path to 
# signalp2 as your second argument"


/home/armita/git_repos/pathogen/rxlr/rxlr_pipeline_part1.sh $SORTED_CONTIGS $SIG_P


#######  Step 1	 ########
# Run RXLR part2		#
#########################

/home/armita/git_repos/pathogen/rxlr/rxlr_pipeline_part2.sh

#######  Step 1	 ########
# Run MIMP detection	#
#########################

/home/armita/git_repos/pathogen/mimp_finder.pl $SORTED_CONTIGS $STRAIN_mimps.fa

#######  Step 1	 ########
# 		Cleanup			#
#########################


mkdir $CUR_PATH/analysis/rxlr/$ORGANISM/$STRAIN/

cp -r $WORK_DIR/. $CUR_PATH/analysis/rxlr/$ORGANISM/$STRAIN/.

rm -r $WORK_DIR/


