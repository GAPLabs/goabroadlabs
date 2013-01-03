class WebcampRegistration < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :email_address

    has_one :code

    validates :first_name, :last_name, :email_address, :presence => "true", 
        :length => { :maximum => 100, :too_long => "must not be more than %{count} characters" } 
    validates :code_id, 
        :numericality => { :only_integer => true, :greater_than => 0, :message => 'you are not allowed to register. please input valid code' }
    validates :email_address, :email => true, :uniqueness => true

    before_save :set_date_registered

    def name
        "#{self.first_name} #{self.last_name}"
    end

    def set_date_registered
        self.date_registered = Date.today
    end
end
