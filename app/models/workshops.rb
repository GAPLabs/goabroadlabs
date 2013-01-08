class Workshops < ActiveRecord::Base
  attr_accessible :title, :description, :facilatators, :year
end
