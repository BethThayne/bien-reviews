class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(username: params[:id])
    end


def new
    #for for a new user
    @user = User.new
end

def create

    # take parameters from form
      @user = User.new(form_params)

       # create new user,  if valid and saves, go to list users page
       if @user.save

        # save session with user
        session[:user_id] = @user.id
        
      
       redirect_to users_path
   else

 # if not, see form with errors
   render "new"
   end
end

    def form_params
        params.require(:user). permit(:username, :email, 
        :password, :password_confirmation)
    end

end




   