class ReviewsController < ApplicationController

def index 
    # reviews list page


    @number = rand(100)

    @reviews = Review.all

end

def new 
    # form for adding a new review
 @review = Review.new
end


def create
    # take info from form and add to database
    @review = Review.new(form_params)

    # save info to database
    @review.save

    # redirect back to homepage
    redirect_to root_path
end


def show
    # individual review page
    @review = Review.find(params[:id])
end

def destroy
    # find individual review
    @review = Review.find(params[:id])

    # destroy
    @review.destroy

    # redirect to homepage
    redirect_to root_path

end

def edit
    # find individual review to edit
    @review = Review.find(params[:id])

end

def update
    # find individual review to edit
    @review = Review.find(params[:id])

    # update with new info from form
    @review.update(form_params)

    # redirect
    redirect_to review_path
end

def form_params
    params.require(:review).permit(:title, :body, :score)

end

end