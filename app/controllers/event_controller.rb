class EventController < ApplicationController
    layout "webcamp"

    def main
    end

    def register

        @attendee = WebcampRegistration.new(params[:webcamp_registration])
        # @attendee.code = 'Code'
        code = Codes.where("code = ?", params[:code]).first
        @attendee.code_id  = code == nil ? 0 : code.id

        if request.post?
            @code = params[:code]
            if @attendee.valid?
                @attendee.date_registered = Date.today
                @attendee.status = 3
            end
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
