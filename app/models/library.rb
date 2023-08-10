# == Schema Information
#
# Table name: libraries
#
#  id   :uuid             not null, primary key
#  name :string           not null
#
class Library < ApplicationRecord
  has_many :books, dependent: :destroy
end
