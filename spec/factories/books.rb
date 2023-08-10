# == Schema Information
#
# Table name: books
#
#  id                :uuid             not null, primary key
#  checked_out       :boolean          default(FALSE), not null
#  checked_out_at    :datetime
#  due_at            :datetime
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
FactoryBot.define do
  factory :book do
    title { Forgery(:name).full_name }

    factory :circulating_book do
      checked_out { false }
      restricted { false }
      on_hold { false }
    end

    factory :checked_out_book do
      before(:create) do |book|
        book.checked_out_by = FactoryBot.create(:user)
      end
      checked_out { true }
      restricted { false }
      on_hold { false }
    end

    factory :restricted_book do
      checked_out { false }
      restricted { true }
      on_hold { false }
    end

    factory :restricted_and_checked_out_book do
      before(:create) do |book|
        book.checked_out_by = FactoryBot.create(:researcher)
      end
      checked_out { true }
      restricted { true }
      on_hold { false }
    end

    factory :book_on_hold do
      checked_out { false }
      restricted { false }
      on_hold { true }
    end

    factory :restricted_and_on_hold_book do
      checked_out { false }
      restricted { true }
      on_hold { true }
    end

    factory :overdue_book do
      checked_out { true }
      checked_out_at { 61.days.ago }
      due_at { 1.day.ago }
    end
  end
end
