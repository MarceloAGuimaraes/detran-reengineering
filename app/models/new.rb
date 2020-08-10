class New < ApplicationRecord
  def self.updated?
    New.count.positive? && New.maximum(:created_at) >= Date.today
  end
end
