class Contact < ApplicationRecord
  has_many :contact_numbers, dependent: :delete_all
  accepts_nested_attributes_for :contact_numbers

  validates_presence_of :first_name, :last_name, :contact_numbers
end
