class VehiclesService
  def initialize(params)
    @agent = Mechanize.new
    @params = params
    @params[:cpf] = @params[:cpf].remove('.', '-') if @params[:cpf].present?
    @request_return = {}
  end

  def cpf
    @params[:cpf]
  end

  def unlicensed
    begin
      # Get in the form page
      page = @agent.get('https://acesso.detran.mg.gov.br/veiculos/situacao-do-veiculo/motivo-de-nao-licenciamento/-/consulta_motivo_nao_licenciamento_veiculo/')
      # Now, we will fill the form with the params
      page.forms.second.field_with(name: 'data[ConsultarMotivoNaoLicenciamentoVeiculo][placa]').value = @params[:placa]
      page.forms.second.field_with(name: 'data[ConsultarMotivoNaoLicenciamentoVeiculo][chassi]').value = @params[:chassi]
      page.forms.second.field_with(name: 'data[ConsultarMotivoNaoLicenciamentoVeiculo][renavam]').value = @params[:renavam]

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
    @request_return[:status], @request_return[:message] = 404, '<p> Não foi encontrado nenhum registro para os dados informados. <p>'
  end

  def negative_certificate
    begin
      # Get in the form page
      page = @agent.get('https://acesso.detran.mg.gov.br/veiculos/certidoes/certidao-negativa-de-propriedade')
      page.forms.second.field_with(name: 'data[CertidaoNegativaPropriedadeVeiculos][cpf]selecionar_gerar_validar').value = @params[:cpf]
      page.forms.second.field_with(name: 'data[CertidaoNegativaPropriedadeVeiculos][nomeproprietario]').value = @params[:nome]
      page.forms.second.field_with(name: 'data[CertidaoNegativaPropriedadeVeiculos][codigo_controle]').value = @params[:selecionar_gerar_validar] || '1'
      page.forms.second.field_with(name: 'data[CertidaoNegativaPropriedadeVeiculos][selecionar_gerar_validar]').value = @params[:selecionar_gerar_validar] || '1'
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
