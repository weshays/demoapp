# In the spirit of convention over configuration, these examples expect
# a spec file that implements them to be set up like this:
#
# -----------------------------------------------------------------------
# require 'rails_helper'
#
# RSpec.describe Api::UsersController type: :controller do
#
#
#   let(:authenticated_user) { authenticate_admin_user }
#   let(:object) { @user }
#   let(:object_name) { 'user' }
#
#   ...
#
# -----------------------------------------------------------------------

# Example usage:
# --------------------------------------------
#   context 'GET #index' do
#     it_behaves_like 'a GET path success for non-admin' do
#       let(:non_admin_authenticated_user) { authenticate_non_admin_user }
#       let(:use_path) { '/api/users' }
#     end
#   end
#
#   context 'GET #show' do
#     it_behaves_like 'a GET path failure for non-admin' do
#       let(:non_admin_authenticated_user) { authenticate_non_admin_user }
#       let(:use_path) { '/api/users' }
#     end
#   end
# --------------------------------------------
shared_examples 'a GET path success for non-admin' do
  let(:response_root_name) { (defined?(json_root_name) ? json_root_name : object_name).pluralize }
  it 'should succeed' do
    auth_get(use_path, non_admin_authenticated_user)
    expect(response).to have_http_status(:success)
  end
end

shared_examples 'a GET path failure for non-admin' do
  let(:response_root_name) { (defined?(json_root_name) ? json_root_name : object_name).pluralize }
  it 'should succeed' do
    auth_get(use_path, non_admin_authenticated_user)
    expect(response).to have_http_status(:unauthorized)
  end
end


# Example usage:
# --------------------------------------------
#   context 'GET #index' do
#     it_behaves_like 'a GET #index success'
#   end
# --------------------------------------------

shared_examples 'a GET #index success' do
  let(:response_root_name) { (defined?(json_root_name) ? json_root_name : object_name).pluralize }
  it 'should succeed' do
    auth_get(use_path, authenticated_user, { per_page: 5 })
    expect(response).to have_http_status(:success)
    expect(json[response_root_name].length).to be <= 5
    expect(json[response_root_name].length).to be < object_name.camelize.constantize.count
  end
end

shared_examples 'a GET non-paginated #index success' do
  let(:response_root_name) { (defined?(json_root_name) ? json_root_name : object_name).pluralize }
  let(:response_count) { defined?(expected_non_paginated_count) ? expected_non_paginated_count : object_name.camelize.constantize.count }
  it 'should succeed' do
    auth_get(use_path, authenticated_user, { paginate: false })
    expect(response).to have_http_status(:success)
    expect(json[response_root_name].length).to eq(response_count)
    expect(json['meta']['currentPage']).to be_nil
  end
end

shared_examples 'a GET #index failure if user not logged in' do
  let(:response_root_name) { (defined?(json_root_name) ? json_root_name : object_name).pluralize }
  it 'should succeed' do
    authenticated_user.token = nil
    auth_get(use_path, authenticated_user, { per_page: 5 })
    expect(response).to have_http_status(:unauthorized)
  end
end

# Example usage:
# --------------------------------------------
#   context 'GET #show' do
#     context 'responds with a valid user ID' do
#       it_behaves_like 'a GET #show success'
#     end
#
#     context 'nonexistent user ID' do
#       it_behaves_like 'a GET #show not found'
#     end
#   end
# --------------------------------------------

shared_examples 'a GET #show success' do
  let(:response_root_name) { (defined?(json_root_name) ? json_root_name : object_name) }
  it 'should succeed' do
    auth_get(use_path, authenticated_user)
    expect(response).to have_http_status(:success)
    expect(json[response_root_name]['id']).to eq(object.id)
  end
end

shared_examples 'a GET #show not found' do
  let(:response_root_name) { (defined?(json_root_name) ? json_root_name : object_name) }
  it 'should succeed' do
    auth_get(use_path, authenticated_user)
    expect(response).to have_http_status(:not_found)
    expect(json).to have_key('error')
  end
end

# Example usage:
# --------------------------------------------
#   context 'POST #create' do
#
#     context 'with valid attributes' do
#       it_behaves_like 'a POST #create success' do
#         let(:test_attrs) { FactoryBot.attributes_for(:user) }
#       end
#     end
#
#     context 'with invalid attributes' do
#       it_behaves_like 'a POST #create failure' do
#         let(:test_attrs) { FactoryBot.attributes_for(:user).merge({ name: nil }) }
#       end
#     end
#   end
# --------------------------------------------

shared_examples 'a POST #create success' do
  let(:request_root_name) { (defined?(json_root_name) ? json_root_name : object_name) }
  it 'should succeed' do
    auth_post(use_path, authenticated_user, { request_root_name => test_attrs })
    expect(response).to have_http_status(:success)
    expect(json).to have_key(request_root_name)
  end
end

shared_examples 'a POST #create failure' do
  let(:request_root_name) { (defined?(json_root_name) ? json_root_name : object_name) }
  it 'should succeed' do
    auth_post(use_path, authenticated_user, { request_root_name => test_attrs })
    expect(response).to have_http_status(:not_acceptable)
    expect(json).to have_key('error')
  end
end

# Example usage:
# --------------------------------------------
#   context 'PUT #update' do
#
#     context 'with valid attributes' do
#       it_behaves_like 'a PUT #update success' do
#         let(:test_attrs) { { name: 'some updated name' } }
#       end
#     end
#
#     context 'with invalid attributes' do
#       it_behaves_like 'a PUT #update failure' do
#         let(:test_attrs) { { name: nil } }
#       end
#     end
#   end
# --------------------------------------------

shared_examples 'a PUT #update success' do
  let(:request_root_name) { (defined?(json_root_name) ? json_root_name : object_name) }
  it 'should succeed' do
    auth_put(use_path, authenticated_user, { request_root_name => test_attrs })
    expect(response).to have_http_status(:success)
    expect(json).to have_key(request_root_name)
  end
end

shared_examples 'a PUT #update failure' do
  let(:request_root_name) { (defined?(json_root_name) ? json_root_name : object_name) }
  it 'should succeed' do
    auth_put(use_path, authenticated_user, { request_root_name => test_attrs })
    expect(response).to have_http_status(:not_acceptable)
    expect(json).to have_key('error')
  end
end

# Example usage:
# --------------------------------------------
#   context 'DELETE #destroy' do
#
#     context 'successful delete' do
#       it_behaves_like 'a DELETE #destroy success'
#     end
#
#     context 'delete fails' do
#       it_behaves_like 'a DELETE #destroy failure' do
#         let(:klass_to_stub) { Batch }
#       end
#     end
#   end
# --------------------------------------------

shared_examples 'a DELETE #destroy success' do
  let(:request_root_name) { (defined?(json_root_name) ? json_root_name : object_name) }
  it 'should succeed' do
    auth_delete(use_path, authenticated_user)
    expect(response).to have_http_status(:success)
    expect(json).to have_key(request_root_name)
  end
end

shared_examples 'a DELETE #destroy failure' do
  let(:request_root_name) { (defined?(json_root_name) ? json_root_name : object_name) }
  it 'should fail to delete' do
    auth_delete(use_path, authenticated_user)
    expect(response).to have_http_status(:not_acceptable)
    expect(json).to have_key('error')
  end
end
