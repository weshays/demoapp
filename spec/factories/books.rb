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
FactoryBot.define do
  factory :book do
    title { Forgery(:name).full_name }
    checked_out { false }

    factory :checked_out_book do
      checked_out { true }
    end

    factory :restricted_book do
      restricted { true }
    end

    factory :restricted_and_checked_out_book do
      checked_out { true }
      restricted { true }
    end
  end
end
