require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      email: Faker::Internet.email,
      name:  Faker::Name.name,
      cpf: Faker::PhoneNumber.subscriber_number(length: 10),
      birth_date: Faker::Date.between(from: '1900-09-12', to: '2000-09-12'),
      password: 'computador',
      password_confirmation: 'computador'
    )
  end
  it "is not valid user" do
    auction = User.new(email: nil)
    expect(auction).to_not be_valid
  end

  describe 'Associations' do
    it { should have_many(:vehicles) }
    it { should have_one(:license) }
  end

  it 'method to_s' do
    assert_equal subject.to_s, subject.name
  end
end
