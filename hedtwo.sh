#!/bin/bash

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo
   echo "**hedtwo.sh** display HLA-II evolutionnary divergence"
   echo
   echo "Syntax: ./hedtwo [-h]"
   echo "options:"
   echo "h     Print this help"
   echo
   echo "gzip installation is necessary before usage"
   echo
   echo "# usage : ./hedtwo.sh "allele1" "allele2" "
   echo "# example : ./hedtwo.sh \"DRB5*02:35\" \"DRB5*02:36\" "
   echo "# example : ./hedtwo.sh \"DPA1*01:03\" \"DPA1*01:10\" "
   echo
}


################################################################################
# Process the input options. Add options as needed.                            #
################################################################################
# Get the options
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
   esac
done

################################################################################
# checking for presence of input parameters					       #	
################################################################################

variable1=${1}
if [ -z "${variable1}" ]
then
	echo "allele1 name not passed as parameter"
	exit 1
fi

variable2=${2}
if [ -z "${variable2}" ]
then 
	echo "allele2 name not passed as parameter"
	exit 1
fi

################################################################################
# Main program                                                                 #
################################################################################


allele1=$1
allele2=$2




echo ""
echo "INPUT ALLELES:" 
echo "	- the first allele is : "$allele1
echo "	- the second allele is : "$allele2




if [[ "$allele1" == "$allele2" ]];then echo "the 2 alleles are equal HED = 0";
else

# zcat /data/database.tsv | grep 'DPA1\*01\:03' | grep 'DPA1\*03\:06'
   echo ""
   echo "HLA class II evolutionnary divergence" 
   echo ""
   echo "**************************************************"
   echo "allele1,allele2,distance" | awk -F "," '{ print $1,"\t",$2,"\t",$3}'
   zcat lib/input.csv.gz |awk -F "," -v pat1="$allele1" -v pat2="$allele2" '$1==pat1 && $2==pat2{ print $1,"\t",$2,"\t",$3 }'
   echo "**************************************************"
fi
exit;
