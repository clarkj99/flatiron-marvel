class CharacterComic < ActiveRecord::Base
  belongs_to :character
  belongs_to :comic
end
