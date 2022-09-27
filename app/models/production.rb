class Production < ApplicationRecord
  has_and_belongs_to_many :genres, join_table: "genres_productions"
  has_and_belongs_to_many :characters, join_table: "characters_productions"
  has_and_belongs_to_many :studios, join_table: "productions_studios"

  validates :title, presence: true, uniqueness: true
  validates :released_date, presence: true
  validates :score, presence: true, uniqueness: true

  validate :allowed_score

  scope :title, -> title {where("title LIKE ?", "%" + title + "%")}

  scope :genre, -> genres {    
    genre_array = (genres.split(',')).map(&:to_i) 
    joins(:genres).where(genres: genre_array)
  }


  def allowed_score
    if score > 5 || score < 1
      errors.add(:score, 'Score must be between 1 and 5')
    end
  end
end
