class Studio < ApplicationRecord
  has_and_belongs_to_many :productions, join_table: "productions_studios"
  has_and_belongs_to_many :characters, join_table: "characters_studios"

  validates :name, presence: true, uniqueness: true
  validates :foundation_date, presence: true

  scope :by_name, -> name {where("name LIKE ?", "%" + name + "%")}
end
