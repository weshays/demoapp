# == Schema Information
#
# Table name: books
#
#  id                :uuid             not null, primary key
#  checked_out       :boolean          default(FALSE), not null
#  on_hold           :boolean          default(FALSE)
#  restricted        :boolean          default(FALSE), not null
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  checked_out_by_id :uuid
#  on_hold_by_id     :uuid
#
# Indexes
#
#  index_books_on_checked_out_by_id  (checked_out_by_id)
#  index_books_on_on_hold_by_id      (on_hold_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (checked_out_by_id => users.id)
#  fk_rails_...  (on_hold_by_id => users.id)
#
class Book < ApplicationRecord
  belongs_to :checked_out_by, class_name: 'User', optional: true
  belongs_to :on_hold_by, class_name: 'User', optional: true
end
