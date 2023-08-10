# == Schema Information
#
# Table name: books
#
#  id                 :uuid             not null, primary key
#  checked_out_at     :datetime
#  due_at             :datetime
#  on_hold_at         :datetime
#  on_hold_expires_at :datetime
#  restricted         :boolean          default(FALSE), not null
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  checked_out_by_id  :uuid
#  library_id         :uuid             not null
#  on_hold_by_id      :uuid
#
# Indexes
#
#  index_books_on_checked_out_by_id  (checked_out_by_id)
#  index_books_on_library_id         (library_id)
#  index_books_on_on_hold_by_id      (on_hold_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (checked_out_by_id => users.id)
#  fk_rails_...  (library_id => libraries.id)
#  fk_rails_...  (on_hold_by_id => users.id)
#
class Book < ApplicationRecord
  belongs_to :checked_out_by, class_name: 'User', optional: true
  belongs_to :on_hold_by, class_name: 'User', optional: true
  belongs_to :library

  before_save :apply_due_at

  def overdue?
    return false if due_at.nil?

    due_at.beginning_of_day < Date.current
  end

  private

  def apply_due_at
    return if changes[:checked_out_at].nil?

    self.due_at = changes[:checked_out_at].last.nil? ? nil : (checked_out_at + 60.days)
  end
end
