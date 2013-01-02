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

                session[:attendee] = @attendee

                redirect_to webcamp_select_workshop_path 
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

    def workshops
        @attendee = session[:attendee]

        @code = Codes.find(@attendee.code_id)

        redirect_to webcamp_register_path if @attendee == nil
        
    end
end
