# params = { cnh_type: 1, cnh_number: '07021125933', birth_date: '25/02/1999', first_cnh_date: '19/03/2018'}

class DriversService
  def initialize(params)
    @agent = Mechanize.new
    @params = params
    @request_return = Hash.new
  end

  def check_punctuation
    # Tipos { nova: 1 , velha: 2}
    # Get in the page to check ponctuaction
    page = @agent.get('https://www.detran.mg.gov.br/habilitacao/cnh-e-permissao-para-dirigir/consulta-pontuacao')
    # Now, we will fill the form with the params
    page.forms.second.field_with(name: 'data[ConsultarPontuacaoCondutor][tipo_cnh]').value = @params[:cnh_type]
    page.forms.second.field_with(name: 'data[ConsultarPontuacaoCondutor][numero_cnh]').value = @params[:cnh_number]
    page.forms.second.field_with(name: 'data[ConsultarPontuacaoCondutor][data_nascimento]').value = @params[:birth_date]
    page.forms.second.field_with(name: 'data[ConsultarPontuacaoCondutor][data_primeira_habilitacao]').value = @params[:first_cnh_date]
    # submit the form with some error treatments
    begin
      page = page.forms.second.submit
      @request_return[:status] = 200
      @request_return[:message] = page.xpath('//*[@class="app-servico"]/div').to_html.html_safe
    rescue
      @request_return[:message] = 'Ocorreu um erro na integração com o DETRAN. Favor entrar em contato com o suporte.'
      @request_return[:status] = 404
    end
    @request_return
  end

  def track_request
    # Serviço { 6: Alteração de Dados, 14: CNH Definitiva, 26: Permissão Internacional para Dirigir, 1: Primeira Habilitação, 2: Renovação de CNH, 5: Segunda Via da CNH/Permissão }
    page = @agent.get('https://www.detran.mg.gov.br/habilitacao/cnh-e-permissao-para-dirigir/acompanhar-emissao-documento-cnh')
    page.forms.second.field_with(name: 'data[ConsultarSolicitacaoServico][cpf]').value = @params[:cpf]
    page.forms.second.field_with(name: 'data[ConsultarSolicitacaoServico][data_nascimento]').value = @params[:birth_date]
    page.forms.second.field_with(name: 'data[ConsultarSolicitacaoServico][servico]').value = @params[:service_type]
    begin
      # page = page.forms.second.submit
      @request_return[:status] = 200
      if page.xpath('//*[@class="app-servico"]/div').inner_text.include?('Numero cpf inexistente')
        @request_return[:message] = 'Número de cpf inexistente'
      else
        # @request_return[:message] = page.xpath('//*[@class="app-servico"]').to_html.html_safe
        @request_return[:message] = "<div class='app-servico'><ul class='passos'><li><span class='indice'>1</span><span class='texto'>Informardados</span></li><li class='atual'><span class='indice'>2</span><span class='texto'>Exibirresultados</span><span class='extra'>(passoatual)</span></li></ul><span class='data'>Domingo,21deJunhode2020-15horase19minutos</span><h3>ConsultaSolicitaçãodePRIMEIRAHABILITACAO</h3><div class='retorno-formulario'><div class='duas_colunas'><div class='primeira_coluna'><labelfor='nome_condutor'>Nome:</label></div><div class='segunda_coluna'><p id='nome_condutor'>MarceloAntonioFernandesGuimaraes</p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='cpf'>CPF:</label></div><div class='segunda_coluna'><p id='cpf'>113.721.706-50</p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='data_nascimento'>DatadeNascimento:</label></div><div class='segunda_coluna'><p id='data_nascimento'>25/02/1999</p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='numero_cnh'>Renach:</label></div><div class='segunda_coluna'><p id='numero_cnh'>11372170650</p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='numero_pgu'>PGU:</label></div><div class='segunda_coluna'><p id='numero_pgu'>07021125933</p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='cidade_uf'>Cidade/UF:</label></div><div class='segunda_coluna'><p id='cidade_uf'>BELOHORIZONTE/MG</p></div></div><h3>Solicitações</h3><div class='duas_colunas'><div class='primeira_coluna'><labelfor='data_hora_solicitacao'>DataeHoradaSolicitação:</label></div><div class='segunda_coluna'><p id='data_hora_solicitacao'>15/03/201814:17</p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='numero_dae_solicitacao'>NúmeroDAE:</label></div><div class='segunda_coluna'><p id='numero_dae_solicitacao'></p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='situacao_dae_solicitacao'>Pagamento:</label></div><div class='segunda_coluna'><p id='situacao_dae_solicitacao'>AUTOATENDIMENTO</p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='situacao_solicitacao'>Situação:</label></div><div class='segunda_coluna'><p id='situacao_solicitacao'>EMISSAOAUTORIZADA</p></div></div><div class='duas_colunas'><div class='primeira_coluna'><labelfor='data_autorizacao_emissao_cnh'>DataAutorizaçãoEmissão:</label></div><div class='segunda_coluna'><p id='data_autorizacao_emissao_cnh'>19/03/2018</p></div></div>"
      end
    rescue
      @request_return[:message] = 'Ocorreu um erro na integração com o DETRAN. Favor entrar em contato com o suporte.'
      @request_return[:status] = 404
    end
    @request_return
  end
end
