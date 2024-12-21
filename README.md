# README

## How to use

### Prerequisites
- Docker installed (e.g. via `brew install --cask docker`)

### Run pipeline
- `docker run -it varigene-pipeline`

## To do
- Setup docker image with these tools installed:
    - fastp
    - bwa
    - samtools
    - bcftools

- Create 'varigene.sh' script doing the following steps:
    1. Download_dos_dados_raw(arquivo_NGS)
    2. Pre_processamento_dos_dados(dados_raw)
    3. Mapeamento_contra_o_genoma_humano(dados_pre_processados, genoma_referencia)
    4. Conversao_sam_para_bam(output_mapeamento)
    5. Identificacao_de_variantes(ficheiro_bam, genoma_referencia)
    6. Filtragem_variantes_por_qualidade(ficheiro_vcf)
    7. Anotacao_de_variantes(ficheiro_vcf_filtrado)
