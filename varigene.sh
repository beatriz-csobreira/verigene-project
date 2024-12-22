#!/bin/bash

# Passo 1: Download_dos_dados_raw(arquivo_NGS)
# dados_raw não foram fornecidos, so we ask user for a URL

# Get URL from user
read -rp "Please enter the URL for the raw data: " url
if [[ -z "$url" ]]; then
  echo "No URL entered. Exiting."
  exit 1
fi

# Get filename from URL and check if it's compressed
filename=$(basename "$url")
if [[ "$filename" == *.gz ]]; then
  wget -O dados_raw.fastq.gz "$url"
  gunzip dados_raw.fastq.gz
else
  wget -O dados_raw.fastq "$url"
fi

# Passo 2: Pre_processamento_dos_dados(dados_raw)
fastp -i dados_raw.fastq -o dados_pre_processados.fastq

# Passo 3: Mapeamento_contra_o_genoma_humano(dados_pre_processados, genoma_referencia)

# Passo 3.1: Download to genoma humano
wget ftp://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz

# Passo 3.2: Unzip
gunzip hg19.fa.gz

# Passo 3.3: Indexar o genoma
bwa index hg19.fa

# Passo 3.4: Alinhamento
bwa mem hg19.fa dados_pre_processados.fastq > output_alinhamento.sam

# Passo 4: Conversão de SAM para BAM
samtools -Sb output_alinhamento.sam

# Passo 5: Identificação de variantes
samtools mpileup -f hg19.fa output_alinhamento.bam > output.pileup
# .pileup file contains read depth and other info at each genomic position

# Passo 6: Filtragem de variantes por qualidade
bcftools call -mv -Ob output.bcf output.pileup
bcftools view output.bcf > output.vcf