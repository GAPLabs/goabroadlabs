class WebcampRegistration < ActiveRecord::Base
    attr_accessible :code, :first_name, :last_name, :email_address
    validates :first_name, :presence => "true" 
end
