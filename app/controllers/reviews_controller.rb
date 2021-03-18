class ReviewsController < ApplicationController

    #check if logged in

    before_action :check_login, except: [:index, :show]

def index 

    @price = params[:price]

    @cuisine = params[:cuisine]

    @location = params[:location]

    # start with all reviews

    @reviews = Review.all

    # filter by price

    if @price.present?

        @reviews = @reviews.where(price: @price)
    end

    # filter by cuisine
    if @cuisine.present?

        @reviews = @reviews.where(cuisine: @cuisine)
    end

    # search near location
    if @location.present?
        @reviews = @reviews.near(@location)
    end
    


end

def new 
    # form for adding a new review
 @review = Review.new
end


def create
    # take info from form and add to model
    @review = Review.new(form_params)

    # then add it to a user

    @review.user = @current_user

    # check if model can be saved
    # if it can, return to home page
    # if it can't, show new form

    if @review.save
        redirect_to root_path
    else
        # show view for new.html.erb
        render "new"
    end


end


def show
    # individual review page
    @review = Review.find(params[:id])
end

def destroy
    # find individual review
    @review = Review.find(params[:id])

    # destroy
 if @review.user == @current_user
    @review.destroy
 end

    # redirect to homepage
    redirect_to root_path

end

def edit
    # find individual review to edit
    @review = Review.find(params[:id])

    if @review.user != @current_user
        redirect_to root_path
    elsif @review.created_at < 1.hour.ago
        redirect_to review_path(@review)
    end

end

def update
    # find individual review to edit
    @review = Review.find(params[:id])

    if @review.user != curent_user
        redirect_to root_path
    else 
         # update with new info from form
        if @review.update(form_params)

        # redirect
        redirect_to review_path(@review)
        else
            render "edit"
        end
    end

   
end

    def form_params
    params.require(:review).permit(:title, :restaurant, :body, :score, :price, :cuisine,  :ambience, :address, :photo)

    end


end
