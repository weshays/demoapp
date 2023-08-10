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
  MAX_BOOKS_ON_HOLD = 5
  MAX_OVERDUE_BOOKS_BEFORE_REJECTING_HOLD = 2

  has_many :books_checked_out, class_name: 'Book', foreign_key: :checked_out_by, dependent: :nullify,
                               inverse_of: :checked_out_by
  has_many :books_on_hold, class_name: 'Book', foreign_key: :on_hold_by, dependent: :nullify, inverse_of: :on_hold_by

  def max_books_on_hold_for_non_researcher?
    books_on_hold.count >= MAX_BOOKS_ON_HOLD && !researcher?
  end

  def max_overdue_books_reached?(library)
    books_checked_out.where(library_id: library.id)
                     .select(&:overdue?)
                     .size >= MAX_OVERDUE_BOOKS_BEFORE_REJECTING_HOLD
  end
end
