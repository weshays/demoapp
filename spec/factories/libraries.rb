# == Schema Information
#
# Table name: libraries
#
#  id   :uuid             not null, primary key
#  name :string           not null
#
FactoryBot.define do
  factory :library do
    name { Forgery(:name).location }
  end
end
