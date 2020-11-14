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
      page = page.forms.second.submit
      @request_return[:status] = 200
      if page.xpath('//*[@class="app-servico"]/div').inner_text.include?('Numero cpf inexistente')
        @request_return[:message] = 'Número de cpf inexistente'
      else
        @request_return[:message] = page.xpath('//*[@class="app-servico"]').to_html.html_safe
      end
    rescue
      @request_return[:message] = 'Ocorreu um erro na integração com o DETRAN. Favor entrar em contato com o suporte.'
      @request_return[:status] = 404
    end
    @request_return
  end
end
