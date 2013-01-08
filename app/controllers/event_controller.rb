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

            attendees = WebcampRegistration.find_all_by_code_id(@attendee.code_id).count

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
        session_limit = 25

        @attendee = session[:attendee]

        @selected_workshops = Array.new(4) { 0 }

        redirect_to webcamp_register_path and return if @attendee == nil

        @code = Codes.find(@attendee.code_id)

        workshops = Workshops.all
        @workshops = workshops.map { |workshop|
            Hash[
                'id' => workshop.id,
                'name' => workshop.title, 
                'first_session_left' => session_limit - WebcampRegistration.where('first_session = ?',workshop.id).size,
                'second_session_left' => session_limit - WebcampRegistration.where('second_session = ?',workshop.id).size,
                'third_session_left' => session_limit - WebcampRegistration.where('third_session = ?',workshop.id).size,
                'fourth_session_left' => session_limit - WebcampRegistration.where('fourth_session = ?',workshop.id).size 
            ] 
        }

        @with_error = false

        if request.post?

            @selected_workshops = params[:workshops]

            unique = @selected_workshops.uniq.count

            if unique  == @selected_workshops.count
                @attendee.first_session = @selected_workshops[0]
                @attendee.second_session = @selected_workshops[1]
                @attendee.third_session = @selected_workshops[2]
                @attendee.fourth_session = @selected_workshops[3]

                redirect_to finish_registration_path  and return          
            else
                @with_error = true
            end
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
        third_session = Workshops.find(@attendee.third_session) if @attendee.third_session > 0
        fourth_session = Workshops.find(@attendee.fourth_session) if @attendee.fourth_session > 0
        
        workshops = Array[]

        workshops << first_session.title unless first_session == nil
        workshops << second_session.title unless second_session == nil
        workshops << third_session.title unless third_session == nil
        workshops << fourth_session.title unless fourth_session == nil

        @workshops = workshops.join(", ")
    end
end
