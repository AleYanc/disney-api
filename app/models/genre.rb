class Genre < ApplicationRecord
  has_and_belongs_to_many :productions, join_table: "genres_productions"

  validates :name, presence: true, uniqueness: true

  scope :by_name, -> name {where("name LIKE ?", "%" + name + "%")}
end
