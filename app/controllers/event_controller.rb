class EventController < ApplicationController
    def main
    end

    def register

        @attendee = WebcampRegistration.new(params[:webcamp_registration])
        # @attendee.code = 'Code'

        if request.post?
            @code = params[:code]
            # @code = Codes.where("code = ?", params[:webcamp_registration][:code]).first

            # @attendee.code_id = @code.id unless @code == nil
            #logger.debug { @attendee.inspect }
        end
        # attendee.first_name = 'Farly'
        # attendee.last_name = 'Taboada'
        # attendee.code_id = 1
        # attendee.date_registered = Date.today
        # attendee.first_session = 1
        # attendee.second_session = 2
        # attendee.email_address = 'farly.taboada@goabroad.com'
        # attendee.status = 1
        # attendee.save
    end

    def create
    end
end
