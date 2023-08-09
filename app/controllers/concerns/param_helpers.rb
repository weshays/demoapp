module ParamHelpers
  extend ActiveSupport::Concern

  # def param_user_id
  #   params[:user_id] || current_user.user_id
  # end

  # def tokenize_search_conditions(fields, search_value)
  #   conditions = []
  #   search_value.to_s.strip.split.each do |token|
  #     field_conditions = fields.map { |field| "(LOWER(#{field}) LIKE '%#{token.downcase}%')" }.join(' OR ')
  #     conditions << ActiveRecord::Base.sanitize_sql("(#{field_conditions})")
  #   end
  #   conditions.join(' AND ')
  # end
end
