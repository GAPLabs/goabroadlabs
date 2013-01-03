class EventController < ApplicationController
    layout "webcamp"

    protect_from_forgery :except => [:workshops, :finish] 

    def main
    end

    def register

        limit = 5

        @attendee = WebcampRegistration.new(params[:webcamp_registration])
        # @attendee.code = 'Code'
        code = Codes.where("code = ?", params[:code]).first

        @attendee.code_id  = code == nil ? 0 : code.id

        if request.post?
            @code = params[:code]

            attendees = WebcampRegistration.find_all_by_code_id(code.id).count

            if attendees >= limit
                flash[:fail] = "Your school reached its max participants"

                redirect_to webcamp_main_path and return
            end

            if @attendee.valid?
                session[:attendee] = @attendee

                redirect_to webcamp_select_workshop_path and return
            end
        end   
    end

    def workshops 
        @attendee = session[:attendee]

        redirect_to webcamp_register_path and return if @attendee == nil

        @code = Codes.find(@attendee.code_id)

        workshops = Workshops.all
        
        @workshops = workshops.map { |workshop|
            Hash[
                'id' => workshop.id,
                'title' => workshop.title, 
                'first_session_count' => WebcampRegistration.where('first_session = ?',workshop.id).size,
                'second_session_count' => WebcampRegistration.where('second_session = ?',workshop.id).size 
            ] 
        }

        if request.post?
            @attendee.first_session = params[:first_session] == nil ? 0 : params[:first_session] 
            @attendee.second_session = params[:second_session] == nil ? 0 : params[:second_session]
            
            redirect_to finish_registration_path  and return          
        end
    end

    def finish
        @attendee = session[:attendee]

        redirect_to webcamp_main_path and return if @attendee == nil

        if request.post?

            if @attendee.valid?
                @attendee.save

                session.delete :attendee

                flash[:success] = "#{@attendee.name}, see you at WebCamp!"
            else
                flash[:fail] = "Error while saving your registration! Try again.."
            end    

            redirect_to webcamp_main_path and return
        end    

        @code = Codes.find(@attendee.code_id)

        first_session = Workshops.find(@attendee.first_session) if @attendee.first_session > 0
        second_session = Workshops.find(@attendee.second_session) if @attendee.second_session > 0
        
        workshops = Array[]

        workshops << first_session.title unless first_session == nil
        workshops << second_session.title unless second_session == nil

        @workshops = workshops.join(" And ")
    end
end
