# This is the README of the bash script for RNASeq Analysis.
# To start the analysis you should have the following:

Make sure you have installed the following:

FastQC : https://anaconda.org/bioconda/fastqc
Trimmomatic : https://anaconda.org/bioconda/trimmomatic
star : https://anaconda.org/bioconda/star
featureCounts : https://anaconda.org/bioconda/subread

# Above is the basic installation needed. You might encounter issues if the systems in not
# configured properly during installation. You're suggested to seek external helpi, in case.


1. Download the copy the RNASeq_v1.1.tar.gz to your working folder in a Linux computer.
2. Copy the raw data directory with all fastq.gz files in the working computer.


Please follow the below steps to perform the analysis:

STEP 1:
tar -xvf RNASeq_v1.1.tar.gz

STEP 2:
cd RNASeq_v1.1

STEP 3:
Open and change the absolute path of the working directory in the below file (IMPORTANT: without the last /):
working_directory_path

save and close the file

STEP 4:
Change the file names in the following three file as given in the examples directory
files
files_features

(No mistake should be there in the file names)

STEP 5:
sh RNASeq.sh

The results can be found at the respective directory::
trimmed_fastq
mapped
featureCounts



