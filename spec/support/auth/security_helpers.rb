module Auth
  module SecurityHelpers
    AuthenticatedUser = Struct.new(:customer_id, :user, :token)

    def authenticate_admin_user
      user = User.where(name: 'Admin User').where(admin: true).first
      user = FactoryBot.create(:admin_user) if user.nil?
      authenticate_user(user)
    end

    def authenticate_non_admin_user
      user = User.where(name: 'NonAdmin User').where(admin: false).first
      user = FactoryBot.create(:sales_user)
      authenticate_user(user)
    end

    def authenticate_user(user)
      resp = Auth::SessionManager.login(user.email, 'Simple123!')
      AuthenticatedUser.new(user.customer_id, user, resp[:token])
    end
  end
end
