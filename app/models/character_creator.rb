class CharacterCreator < ActiveRecord::Base
  belongs_to :character
  belongs_to :creator
end
