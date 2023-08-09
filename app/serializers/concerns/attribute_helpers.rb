module AttributeHelpers
  extend ActiveSupport::Concern

  def created_at_null_or_timestamp
    object.created_at&.to_i
  end

  def updated_at_null_or_timestamp
    object.updated_at&.to_i
  end
end
