class VehiclesService
  def initialize(params)
    @agent = Mechanize.new
    @params = params
    @request_return = Hash.new
  end

  def unlicensed
    # Get in the form page
    page = @agent.get('https://www.detran.mg.gov.br/veiculos/situacao-do-veiculo/motivo-de-nao-licenciamento/-/consulta_motivo_nao_licenciamento_veiculo/')
    # Now, we will fill the form with the params
    page.forms.second.field_with(name: 'data[ConsultarMotivoNaoLicenciamentoVeiculo][placa]').value = @params[:placa]
    page.forms.second.field_with(name: 'data[ConsultarMotivoNaoLicenciamentoVeiculo][chassi]').value = @params[:chassi]
    page.forms.second.field_with(name: 'data[ConsultarMotivoNaoLicenciamentoVeiculo][renavam]').value = @params[:renavam]
    begin
      # submit the form with crawler
      page = page.forms.second.submit
      @request_return[:status] = 200
      @request_return[:message] = page.xpath('//*[@class="app-servico"]/div').to_html.html_safe
    rescue
      standard_error
    end
    @request_return
  end

  def standard_error
    @request_return[:status], @request_return[:message]= 404, 'Ocorreu um erro na comunicação com o sistema do DETRAN - Minas Gerais. Favor entrar em contato com o suporte.'
  end

  def negative_certificate
    # Get in the form page
    page = @agent.get('https://www.detran.mg.gov.br/veiculos/certidoes/certidao-negativa-de-propriedade')
    page.forms.second.field_with(name: 'data[CertidaoNegativaPropriedadeVeiculos][cpf]').value = @params[:cpf]
    page.forms.second.field_with(name: 'data[CertidaoNegativaPropriedadeVeiculos][nomeproprietario]').value = @params[:nome]
    page.forms.second.field_with(name: 'data[CertidaoNegativaPropriedadeVeiculos][codigo_controle]').value = @params[:selecionar_gerar_validar]
    begin
      # submit the form with crawler
      page = page.forms.second.submit
      @request_return[:status] = 200
      @request_return[:message] = page.xpath('//*[@class="app-servico"]/div').to_html.html_safe
    rescue
      standard_error
    end
    @request_return
  end
end
