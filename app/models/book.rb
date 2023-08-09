# == Schema Information
#
# Table name: books
#
#  id          :uuid             not null, primary key
#  checked_out :boolean          default(FALSE), not null
#  restricted  :boolean          default(FALSE), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Book < ApplicationRecord
end
