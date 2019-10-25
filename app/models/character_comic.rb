class CharacterComic < ApplicationRecord
  belongs_to :character
  belongs_to :comic
end
