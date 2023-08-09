require 'rails_helper'

RSpec.describe Auth::SessionManager, type: :service do
  before do
    @user = FactoryBot.create(:user)
    @token_resp = Auth::SessionManager.login(@user.email, 'Simple123!')
  end

  context 'class methods' do
    it 'should validate the token' do
      expect(Auth::SessionManager.valid?(@token_resp[:token])).to be_truthy
    end
  end
end
