# get latest ubuntu image
FROM ubuntu:latest

# update and install necessary tools
RUN apt-get update && apt-get install -y \
    fastp \
    bwa \
    samtools \
    bcftools

# create working directory and run varigene.sh per default
WORKDIR /varigene
COPY varigene.sh /varigene/
CMD ["./varigene.sh"]