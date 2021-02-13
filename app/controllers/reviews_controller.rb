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
    # take info from form and add to model
    @review = Review.new(form_params)

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
    if @review.update(form_params)

    # redirect
    redirect_to review_path(@review)
    else
        render "edit"
    end
end

def form_params
    params.require(:review).permit(:title, :restaurant, :body, :score, :ambience)

end


end
