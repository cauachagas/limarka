# coding: utf-8
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'limarka'
require 'yaml'
require 'pry-byebug'

def modelo_dir
  Dir.pwd + '/modelo-oficial'
end

def cria_copia_do_modelo(output_dir)
  FileUtils.rm_rf output_dir
  FileUtils.mkdir_p output_dir
  FileUtils.cp_r "#{modelo_dir}/imagens",output_dir
  FileUtils.cp_r "#{modelo_dir}/templates",output_dir
  ['latexcustomizacao.sty'].each do |f|
    FileUtils.cp_r "#{modelo_dir}/#{f}",output_dir
  end
end

@configuracao_padrao = nil
## Para regerar o arquivo de configuração invoke rake configuracao_padrao
def configuracao_padrao
  ## TODO: criar a configuracao padrão, caso não exista: invocar rake configuracao_padrao
  @configuracao_padrao = @configuracao_padrao or YAML.load_file('spec/configuracao_padrao/configuracao.yaml')
end

# Retorna o texto do pdf
def pdftext(pdf_file)
  <<-PDF
Citações podem ser numéricas (1).

Referências

1 ASSOCIAÇÃO BRASILEIRA"
PDF
end


def hash_to_yaml(h)
  s = StringIO.new
  s << h.to_yaml
  s << "---\n\n"
  s.string
end
