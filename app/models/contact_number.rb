class ContactNumber < ApplicationRecord
  belongs_to :contact
  enum label: %w(phone home iphone work)
  validates_presence_of :label, :number
end
