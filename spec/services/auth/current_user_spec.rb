require 'rails_helper'

RSpec.describe Auth::CurrentUser, type: :service do
  before do
    @user = FactoryBot.create(:admin_user)
    @token_resp = Auth::SessionManager.login(@user.email, 'Simple123!')
    @token_user_info = Auth::SessionManager.info(@token_resp[:token])
  end

  context 'instance methods' do
    it 'present? should return true if token is present in the data' do
      expect(Auth::CurrentUser.present?(@token_resp[:token])).to be_truthy
    end

    it 'present? should return true if token is present' do
      current_user = Auth::CurrentUser.new(@token_user_info)
      expect(current_user.present?).to be_truthy
    end

    it 'admin? should return true if user is an admin' do
      current_user = Auth::CurrentUser.new(@token_user_info)
      expect(current_user.admin?).to be_truthy
    end

    it 'user_id should return the user_id' do
      current_user = Auth::CurrentUser.new(@token_user_info)
      expect(current_user.user_id).to eq(@user.id)
    end

    it 'user should return the user' do
      current_user = Auth::CurrentUser.new(@token_user_info)
      expect(current_user.user).to eq(@user)
    end
  end
end
