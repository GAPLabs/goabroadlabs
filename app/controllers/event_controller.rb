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
                session[:attendee] = @attendee

                redirect_to webcamp_select_workshop_path 
            end
        end   
    end

    def workshops
        @attendee = session[:attendee]

        redirect_to webcamp_register_path if @attendee == nil

        @code = Codes.find(@attendee.code_id)

        workshops = Workshops.all
        
        @workshops = workshops.map { |workshop|
            Hash[
                'id' => workshop.id,
                'title' => workshop.title, 
                'first_session_count' => WebcampRegistration.where('first_session = ?',workshop.id).size,
                'second_session_count' => WebcampRegistration.where('second_session = ?',workshop.id).size ] 
        }        
    end
end
