# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  researcher :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_name        (name)
#  index_users_on_researcher  (researcher)
#
class User < ApplicationRecord
  has_many :books_checked_out, class_name: 'Book', foreign_key: :checked_out_by
  has_many :books_on_hold, class_name: 'Book', foreign_key: :on_hold_by
end
