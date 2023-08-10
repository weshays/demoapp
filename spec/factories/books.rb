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
FactoryBot.define do
  factory :book do
    before(:create) do |book|
      book.library = FactoryBot.create(:library) if book.library.blank?
    end

    title { Forgery(:name).full_name }

    factory :circulating_book do
      checked_out_at { nil }
      restricted { false }
      on_hold_at { nil }
    end

    factory :checked_out_book do
      before(:create) do |book|
        book.checked_out_by = FactoryBot.create(:user) if book.checked_out_by.blank?
      end
      checked_out_at { Time.current }
      restricted { false }
      on_hold_at { nil }
    end

    factory :restricted_book do
      checked_out_at { nil }
      restricted { true }
      on_hold_at { nil }
    end

    factory :restricted_and_checked_out_book do
      before(:create) do |book|
        book.checked_out_by = FactoryBot.create(:researcher) if book.checked_out_by.blank?
      end
      checked_out_at { Time.current }
      restricted { true }
      on_hold_at { nil }
    end

    factory :book_on_hold do
      checked_out_at { nil }
      restricted { false }
      on_hold_at { Time.current }
    end

    factory :restricted_and_on_hold_book do
      checked_out_at { nil }
      restricted { true }
      on_hold_at { Time.current }
    end

    factory :overdue_book do
      checked_out_at { 70.days.ago }
      due_at { 10.day.ago }
      on_hold_at { nil }
    end
  end
end
