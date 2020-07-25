# Class to basic and static values from detran platform

class Detran
  extend ActiveSupport::Concern

  SERVICES_TYPES = {
    '6': 'Alteração de Dados',
    '14': 'CNH Definitiva',
    '26': 'Permissão Internacional para Dirigir',
    '1': 'Primeira Habilitação',
    '2': 'Renovação de CNH',
    '5': 'Segunda Via da CNH/Permissão'
  }

  def self.services_types
    SERVICES_TYPES
  end
end
