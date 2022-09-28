class Character < ApplicationRecord
  has_and_belongs_to_many :productions, join_table: "characters_productions"
  has_and_belongs_to_many :studios, join_table: "characters_studios"

  validates :name, presence: true, uniqueness: true
  validates :age, presence: true
  validates :weight, presence: true
  validates :history, presence: true

  scope :by_name, -> name{where("name LIKE ?", "%" + name + "%")}
  scope :by_age, -> from, to { where("age >= ? AND age <= ?", from, to) }
  scope :by_weight, -> from, to { where("weight >= ? AND weight <= ?", from, to) }
  scope :by_production, -> productions {    
    productions_array = (productions.split(',')).map(&:to_i)
    joins(:productions).where(productions: productions_array)
  }
end
