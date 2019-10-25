class Character < ApplicationRecord
  has_many :character_comics
  has_many :comics, through: :character_comics

  has_many :character_creators
  has_many :creators, through: :character_creators

  has_many :comic_creators, through: :comics
end
