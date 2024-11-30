require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:artist) { FactoryBot.build(:artist) }
  context 'Should validate' do
    it 'with valid fields' do
      expect(artist).to be_valid
    end
  end

  #context 'when email is not valid' do
    #let(:student) { FactoryBot.build(:artist, email: nil) }

    #it 
  #pending "add some examples to (or delete) #{__FILE__}"
end
