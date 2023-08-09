module ErrorMessages
  extend ActiveSupport::Concern

  def access_denied
    render json: { error: 'Unauthorized Request' }.to_json, status: :unauthorized
  end

  def forbidden(message)
    render json: { error: message }.to_json, status: :forbidden
  end

  def internal_server_error(error_message)
    render json: { error: error_message }, status: :internal_server_error
  end

  def not_acceptable(error_message)
    if !error_message.is_a?(String) && error_message.respond_to?(:errors)
      error_message = error_message.errors.messages.values.flatten.join(', ')
    end
    render json: { error: error_message }, status: :not_acceptable
  end

  def record_not_found(error_message)
    render json: { error: error_message }, status: :not_found
  end

  def service_unavailable(error_message)
    render json: { error: error_message }, status: :service_unavailable
  end

  def unable_to_authenticate(message)
    render json: { error: message }, status: :not_acceptable
  end

  def unprocessable_entity(error_message)
    render json: { error: error_message }, status: :unprocessable_entity
  end
end
