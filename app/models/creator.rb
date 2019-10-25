class Creator < ApplicationRecord
  has_many :comic_creators
  has_many :comics, through: :comic_creators

  has_many :character_creators
  has_many :characters, through: :character_creators
end
