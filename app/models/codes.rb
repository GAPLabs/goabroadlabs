class Codes < ActiveRecord::Base
  attr_accessible :code, :owner, :description 
end
