class EventController < ApplicationController
    layout "webcamp"

    protect_from_forgery :except => [:workshops, :finish] 
    
    def main    
    end
    
    def register
        @codeError = ""

        if request.post?
            if params[:code] == ""
                @codeError = "School code is required."
            else  
                code = Codes.where("code = ?", params[:code]).first
                if( code == nil )
                    @codeError = "School code is invalid."
                else   
                    contact = SchoolContact.where("code_id = ?", code.code).first
                    if contact != nil
                        @codeError = "Your school already has registered participants."
                    else
                        session[:code_id] = params[:code]
                        redirect_to finish_registration_path and return    
                    end
                end    
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
        code = session[:code_id]

        redirect_to webcamp_main_path  and return  if code == nil

        @schoolCode = Codes.where("code = ?", code).first
        
        @hasErrors = false        
        @participants = Array.new
        @errorMessage = Array.new 
        @email = ''
        
        if request.post?
            registrationInfo = params[:registration]
            @participants = registrationInfo[:participants]
            @email = registrationInfo[:school_contact]
            
            # check errors
            if @participants.size < 3
                @hasErrors = true
                @errorMessage << "Please register at least 3 participants."
            end 
               
            @participants.each do | participant |
                if participant[1]["name"] == ''
                    @hasErrors = true
                    @errorMessage << "Participants' names are required."
                end    
            end
            
            if registrationInfo[:school_contact] == ''
                @hasErrors = true
                @errorMessage << "Email address is required."
            else    
                if !registrationInfo[:school_contact].match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
                    @hasErrors = true
                    @errorMessage << "The provided email address is invalid."
                end
            end 
            
            if !@hasErrors   
                @participants.each do | participant |
                    newParticipant = Participant.new
                    newParticipant.name = participant[1]["name"]
                    newParticipant.buying_shirt = participant[1]["buying_shirt"] == nil ? 0 : participant[1]["buying_shirt"]
                    newParticipant.shirt_size = participant[1]["shirt_size"]
                    newParticipant.code_id = code
                    newParticipant.date_registered = Date.today
                    newParticipant.save
                end
                
                schoolContact = SchoolContact.new
                schoolContact.code_id = code
                schoolContact.email = registrationInfo[:school_contact]
                schoolContact.save
                
                redirect_to reminders_path and return
            end    
        end     
    end
    
    def reminders
        @schoolCode = Codes.where("code = ?", session[:code_id]).first

        redirect_to webcamp_main_path and return if request.post?
    end
    
    def render_add_participant_partial
        render :json => {
            :html => render_to_string({
                :partial => "event/addParticipant",
                :locals => {
                    :counter => params[:counter],
                    :participant => nil
                }
            })
        }
    end
end
