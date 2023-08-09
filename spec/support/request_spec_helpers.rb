module RequestSpecHelpers
  def unauth_get(use_path, params = {})
    get use_path, params: params
  end

  def unauth_post(use_path, params = {})
    post use_path, params: params
  end

  def unauth_put(use_path, params = {})
    put use_path, params: params
  end

  def auth_get(use_path, authenticated_user, params = {})
    get use_path, headers: { Authorization: "Bearer #{authenticated_user.token}" }, params: params
  end

  def auth_post(use_path, authenticated_user, params = {})
    post use_path, headers: { Authorization: "Bearer #{authenticated_user.token}" }, params: params
  end

  def auth_put(use_path, authenticated_user, params = {})
    put use_path, headers: { Authorization: "Bearer #{authenticated_user.token}" }, params: params
  end

  def auth_delete(use_path, authenticated_user, params = {})
    delete use_path, headers: { Authorization: "Bearer #{authenticated_user.token}" }, params: params
  end

  def json
    JSON.parse(response.body)
  end

  def symbolized_json_response
    JSON.parse(response.body, symbolize_names: true)
  end
end
