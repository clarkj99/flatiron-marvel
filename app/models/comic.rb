class Comic < ActiveRecord::Base
  has_many :comic_creators
  has_many :creators, through: :comic_creators

  has_many :character_comics
  has_many :comics, through: :character_comics
end
