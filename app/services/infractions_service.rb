class InfractionsService
  def initialize(params)
    @agent = Mechanize.new
    @params = params
    @request_return = Hash.new
  end

  def standard_error
    { message: 'Ocorreu um erro na integração com o DETRAN. Favor entrar em contato com o suporte.',
      status: 404
    }
  end

  def infraction_result
    page = @agent.get('https://www.detran.mg.gov.br/infracoes/central-de-pontuacao/consulta-resultado-fici')
    if @params[:by_plate]
      page.forms.second.field_with(name: 'data[ConsultarProcedimentoAdministrativoPorNumeroPlaca][placa]').value = @params[:plate]
      page.forms.second.field_with(name: 'data[ConsultarProcedimentoAdministrativoPorNumeroPlaca][chassi]').value = @params[:chassi]
    else
      page.forms.second.field_with(name: 'data[ConsultarProcedimentoAdministrativoPorNumeroPlaca][numero_procedimento]').value = @params[:number]
      page.forms.second.field_with(name: 'data[ConsultarProcedimentoAdministrativoPorNumeroPlaca][renavam]').value = @params[:renavam]
    end
    # submit the form with some error treatments
    begin
      page = page.forms.second.submit
      @request_return[:status] = 200
      @request_return[:message] = page.xpath('//*[@class="app-servico"]/div').to_html.html_safe
    rescue
      @request_return = standard_error
    end
    @request_return
  end

  def assessment_defense
    page = @agent.get('https://www.detran.mg.gov.br/infracoes/autuacoes/defesa-de-autuacao-detran-mg')
    if @params[:plate].present?
      page.forms.second.field_with(name: 'data[ConsultaDefesasVeiculoCpfCnpj][placa]').value = @params[:plate]
    elsif @params[:defense_number].present?
      page.forms.second.field_with(name: 'data[ConsultaDefesasVeiculoCpfCnpj][numero_defesa]').value = @params[:defense_number]
    else
      page.forms.second.field_with(name: 'data[ConsultaDefesasVeiculoCpfCnpj][cpf_cnpj]').value = @params[:document_number]
    end
    # submit the form with some error treatments
    begin
      page = page.forms.second.submit
      @request_return[:status] = 200
      @request_return[:message] = page.xpath('//*[@class="app-servico"]/div').to_html.html_safe
    rescue
      @request_return = standard_error
    end
    @request_return
  end
end