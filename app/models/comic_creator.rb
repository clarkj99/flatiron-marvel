class ComicCreator < ActiveRecord::Base
  belongs_to :comic
  belongs_to :creator
end
