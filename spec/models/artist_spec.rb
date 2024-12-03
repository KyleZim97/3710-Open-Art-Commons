require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:artist) { FactoryBot.build(:artist) }

  # valid fields test
  context 'Should Validate' do
    it 'with valid fields' do
      expect(artist).to be_valid
    end
  end

  # non valid fields tests. expected failure/sad paths
  context 'Should Not Validate' do
    it 'without a valid email' do
      artist.email = nil
      expect(artist).not_to be_valid
    end

    # starting with a fresh artists after updating the email
    let(:artist) { FactoryBot.build(:artist) }
    it 'without a valid username' do
      artist.username = nil
      expect(artist).not_to be_valid
    end

    # test for about_artist being nil
    let(:artist) { FactoryBot.build(:artist) }
    it 'without a valid about_artist' do
      artist.about_artist = nil
      expect(artist).not_to be_valid
    end

    # test for password being nil
    let(:artist) { FactoryBot.build(:artist) }
    it 'without a valid password' do
      artist.password = nil
      expect(artist).not_to be_valid
    end

    # test for password_confirmation being nil
    let(:artist) { FactoryBot.build(:artist) }
    it 'without a valid password_confirmation' do
      artist.password_confirmation = nil
      expect(artist).not_to be_valid
    end

    # test for improper email
    let(:artist) { FactoryBot.build(:artist) }
    it 'with an improper email' do
      artist.email = "email"
      expect(artist).not_to be_valid
    end

    # test for duplicate emails
    let(:artist) { FactoryBot.build(:artist) }
    it 'with a duplicate email' do
      FactoryBot.create(:artist, email: 'test@example.com')
      artist.email = 'test@example.com'
      expect(artist).not_to be_valid
    end

    # test for improper passwords
    let(:artist) { FactoryBot.build(:artist) }
    it 'with a short password' do
      artist.password = 'Pass'
      artist.password_confirmation = 'Pass'
      expect(artist).not_to be_valid
    end
  end

  # testing art association with artist 1 to many
  context "Should allow many associated art" do
    let(:artist) { FactoryBot.build(:artist) }
    it 'can have many associated arts' do
      artist.save
      art1 = FactoryBot.create(:art, artist: artist)
      art2 = FactoryBot.create(:art, artist: artist)

      expect(artist.arts).to include(art1, art2)
    end
  end

  # testing successful deletion of art when artist is destroyed
  context "Should destroy all associated art when artist destroyed" do
    let(:artist) { FactoryBot.build(:artist) }
    it 'destroys art' do
      artist.save
      art1 = FactoryBot.create(:art, artist: artist)

      expect { artist.destroy }.to change(Art, :count).by(-1)
    end
  end
end