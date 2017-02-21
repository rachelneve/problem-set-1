#! /usr/bin/env bash 

data="/Users/rachel/data-sets-master"
states="$data/misc/states.tab.gz"
sample="$data/fasta/sample.fa"
cpg="$data/bed/cpg.bed.gz"
SP1="$data/fastq/SP1.fq"
hamlet="$data/misc/hamlet.txt"
gene="$data/bed/genes.hg19.bed.gz"
peaks="$data/bed/peaks.chr22.bed.gz"
lamina="$data/bed/lamina.bed"

# Which state has the lowest murder rate
answer_1=$(gzcat $states \
    | grep -v '^#' \
    | cut -f1,6 \
    | sort -k2n \
    | head -n1 \
    | cut -f1 \
    | sed 's/"//g') 
echo "answer-1: $answer_1"

# How many sequence records are in sample.fa?
answer_2=$( grep '^>' $sample \
 | wc -l)
 echo "answer-2: $answer_2"

 #How many unique CpG IDs are in cpg.bed.gz?
 answer_3=$(cut -f4 $cpg \
 | sort -u \
 | wc -l)
 echo "answer-3: $answer_3"

 #How many sequence records are in SP1.fq?
 answer_4=$(grep '+$' $SP1 \
 |wc -l)
 echo "answer-4: $answer_4"

 #How many words are on lines containing the word bloody in hamlet.txt?
 answer_5=$(grep -i 'bloody' $hamlet \
 | wc -w)
 echo "answer-5: $answer_5"

 #What is the sequence length in the first record in sample.fa?
 answer_6=$(grep -v '^>' $sample \
 | head -1 \
 | tr -d "\n" \
 | wc -c)
 echo "answer-6: $answer_6"

 #What is the name of the longest gene in genes.hg19.bed.gz?
 answer_7=$(gzcat $gene \
 | cut -f2,3,4 \
 | awk '{OFS="\t"}{print $2-$1, $3}' \
 | sort -k1nr \
 | cut -f2 \
 | head -1)
 echo "answer-7: $answer_7"

 #How many unique chromosomes are in genes.hg19.bed.gz?
 answer_8=$(cut -f1 $gene \
 | sort -u \
 | wc -l)
 echo "answer-8: $answer_8"

 #How many intervals are associated with CTCF in in peaks.chr22.bed.gz?
answer_9=$(gzcat $peaks \
| grep -v 'CTCFL' \
| grep 'CTCF' \
| wc -l)
echo "answer-9: $answer_9"

#Which chromosome covers the largest interval in lamina.bed?
answer_10=$(awk '{print $1, $2, $3}' $lamina \
| awk '{OFS="\t"} {print $1, $3 - $2}' \
| sort -k2nr \
| cut -f1 \
| head -1)
echo "answer-10: $answer_10"
