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
FactoryBot.define do
  factory :user do
    name { 'Regular Patron' }
    researcher { false }

    factory :researcher do
      name { 'Researcher Patron' }
      researcher { true }
    end
  end
end
