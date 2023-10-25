class ViewingPartiesController < ApplicationController 
  def new
    if session[:user_id]
      @user = User.find(session[:user_id])
      @movie = Movie.find(params[:movie_id])
    else
      redirect_to movie_path(params[:movie_id])
      flash[:error] = "Must be logged in."
    end
  end 
  
  def create 
    user = User.find(session[:user_id])
    user.viewing_parties.create(viewing_party_params)
    redirect_to "/dashboard"
  end 

  private 

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 
end 