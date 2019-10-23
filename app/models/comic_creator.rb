class ComicCreator < ActiveRecord::Base
  belongs_to :comic
  belongs to :creator
end
