require 'rails_helper'


RSpec.describe User, type: :model do
  let(:my_user){
    User.create(username: 'isaac',
    email: 'isaac_rules@gmail.com',
    password: 'password1234567891011121314151617181920'
    )
  }

  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}

  describe 'uniqueness' do
    before :each do
      create(:user)
    end

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end

  describe 'is_password?' do
    let!(:user) {create(:user) }

    context "context with a valid password" do
      it "should return true" do
        expect(user.is_password?("password")).to be true
      end
    end

    context "with an invalid password" do
      it "should return false" do
        expect(user.is_password?("f")).to be false
      end
    end
  end

  describe 'pasword encyrption' do
    it 'does not save passwords to the database' do
      FactoryBot.create(:user, username: "Draco Malfoy")

      user = User.find_by(username: "Draco Malfoy")
      expect(user.password).not_to eq('password')
    end

    it 'encrypts password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('abc')
      FactoryBot.build(:user, password: 'abc')
    end
  end




end
