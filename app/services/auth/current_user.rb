module Auth
  class CurrentUser
    delegate :customer, to: :user

    def self.present?(token_info)
      obj = new(token_info)
      obj.present?
    end

    def initialize(token_info)
      @token_info = token_info || {}
    end

    def admin?
      @token_info[:admin]
    end

    def present?
      @token_info.present?
    end

    def user_id
      @token_info[:user_id]
    end

    def user
      @user ||= User.find(@token_info[:user_id])
    end
  end
end
