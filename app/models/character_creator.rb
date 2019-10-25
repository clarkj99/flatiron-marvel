class CharacterCreator < ApplicationRecord
  belongs_to :character
  belongs_to :creator
end
