require "rails_helper"

RSpec.describe UserSignUpMailer, type: :mailer do
  describe 'Send sign-up email' do
    before(:all) do
      @user = FactoryBot.build(:user)
      @mail = UserSignUpMailer.send_signup_email(@user)
    end

    it 'renders the subject' do
      expect(@mail.subject).to eq("Registro Alkemy DisneyAPI")
    end

    it 'renders reciever email' do
      expect(@mail.to).to eq([@user.email])
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(['aleyanc2000@gmail.com'])
    end
  end
end
