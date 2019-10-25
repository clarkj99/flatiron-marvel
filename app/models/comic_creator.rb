class ComicCreator < ApplicationRecord
  belongs_to :comic
  belongs_to :creator
end
