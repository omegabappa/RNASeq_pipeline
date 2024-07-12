#!/bin/bash

##
rawdata=`cat working_directory_path`
maxthread=16

##FAST-Q QUALITY CONTROL
##mkdir -p fastqc_outputs
##find ${rawdata}/ -name "*.fq.gz" | xargs fastqc -o fastqc_outputs

##MULTI-QC
## multiqc .

##TRIMMING
#mkdir -p trimmed_fastq
#for i in `cat files`
#do
   # base=`echo ${i}`
    #trimmomatic PE -threads ${maxthread} -phred33 ${rawdata}/${base}_1.fq.gz ${rawdata}/${base}_2.fq.gz trimmed_fastq/${base}_1_trimmed_clean.fq.gz trimmed_fastq/${base}_1_trimmed.unpaired.fq.gz trimmed_fastq/${base}_2_trimmed_clean.fq.gz trimmed_fastq/${base}_2_trimmed.unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 HEADCROP:12 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:30

#done

##MULTI-QC
# multiqc .

##CREATE HUMAN GENOME INDEX STAR
#mkdir -p genomeIndex
#STAR --runMode genomeGenerate --genomeDir genomeIndex --genomeFastaFiles hg38.fa --runThreadN ${maxthread}
#wait

##STAR human_MAPPING
#mkdir -p mapped_STAR
#for i in `cat files`
#do
   # base=`echo ${i}` 
    #echo $base
    #STAR --genomeDir genomeIndex --runThreadN ${maxthread} --readFilesIn trimmed_fastq/${base}_1_trimmed_clean.fq.gz trimmed_fastq/${base}_2_trimmed_clean.fq.gz --outFileNamePrefix mapped/${base} --outSAMtype BAM SortedByCoordinate --outSAMunmapped None --outFilterMismatchNmax 3 --outFilterMultimapNmax 1 --outSAMattributes All --readFilesCommand zcat 

#done

##CREATE MOUSE GENOME INDEX STAR - UCSC: hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/ : chromFA.tar.gz & genes/mm10.ensGene.gtf.gz
##mkdir -p genomeIndexMouse
##STAR --runMode genomeGenerate --genomeDir genomeIndexMouse --genomeFastaFiles Mus_musculus.GRCm39.dna.primary_assembly.fa --runThreadN ${maxthread}
##wait

##STAR mouse_MAPPING
##mkdir -p mapped_STAR
##for i in `cat files`
##do
##    base=`echo ${i}` 
##    echo $base
##   STAR --genomeDir genomeIndexMouse --runThreadN ${maxthread} --readFilesIn trimmed_fastq/${base}_1_trimmed_clean.fq.gz trimmed_fastq/${base}_2_trimmed_clean.fq.gz --outFileNamePrefix mapped_STAR/${base} --outSAMtype BAM SortedByCoordinate --outSAMunmapped None --outFilterMismatchNmax 3 --outFilterMultimapNmax 1 --outSAMattributes All --readFilesCommand zcat 

##done

##HISAT2 mouse_MAPPING
 ##mkdir -p mapped_HISAT2
##for i in `cat files` 
##do 
##     base=`echo ${i}`
##     hisat2 -x /lower_bay/local_storage/annotation_db/Mus_musculus/mm10_hisat2_index/genome -1 trimmed_fastq/${base}_1_trimmed_clean.fq.gz -2 trimmed_fastq/${base}_2_trimmed_clean.fq.gz -p 16 | samtools sort -@ 8 -o mapped_HISAT2/${base}.sorted.bam > ${i}_log
##	 samtools index mapped_HISAT2/${base}.sorted.bam
##done

##FEATURECOUNTS_Human
#mkdir -p featureCounts
#for i in `cat files_features`
#do
    #base=`echo ${i}`
    #featureCounts -p -t gene -g gene_id  -a Homo_sapiens.GRCh38.106.gtf -o featureCounts/counts_${base}.txt mapped/${base}*.bam

#done

##FEATURECOUNTS_STAR_Mouse
##mkdir -p featureCounts_STAR
##for i in `cat files_features`
##do
    ##base=`echo ${i}`
   ##featureCounts -p -t exon -g gene_id  -a Mus_musculus.GRCm39.109.gtf -o featureCounts_STAR/counts_${base}.txt mapped_STAR/${base}*.bam

##done

##FEATURECOUNTS_HISAT2_Mouse
mkdir -p featureCounts_HISAT2
for i in `cat files_features`
do
    base=`echo ${i}`
    featureCounts -p -t exon -g gene_id -a genes.gtf  -o featureCounts_HISAT2/counts_exon${base}.txt mapped_HISAT2/group_2/${base}*.bam

done


##/lower_bay/local_storage/annotation_db/Mus_musculus/Ensembl/GRCm38/Annotation/Archives/archive-2014-05-23-16-04-56/Genes/genes.gtf
