class SessionsController < ApplicationController

    def new
    end

    def create
# try and log in

        @form_data = params.require(:session)

# pull out username and password from form data

@username = @form_data[:username]
@password = @form_data[:password]

# check user is who they say they are

@user = User.find_by(username: @username).try(:authenticate, @password)


# if user present redirect to homepage 

if @user 


    # save user to that user's session

    session[:user_id] = @user.id


    redirect_to root_path

else
    render "new"
end

    end

    def destroy
        # log out - remove session completely
        reset_session

        # redirect to login page

        redirect_to new_session_path
    end



end
