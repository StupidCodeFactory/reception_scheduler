class Establishment < ApplicationRecord
  has_many :shifts

  validates_presence_of :name
end
