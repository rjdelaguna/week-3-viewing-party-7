class ViewingPartiesController < ApplicationController 
  def new
    unless session[:user_id] == params[:user_id].to_i
      redirect_to movie_path(params[:user_id], params[:movie_id])
      flash[:error] = "Must be logged in."
    end
    @user = User.find(params[:user_id])
    @movie = Movie.find(params[:movie_id])
  end 
  
  def create 
    user = User.find(params[:user_id])
    user.viewing_parties.create(viewing_party_params)
    redirect_to "/users/#{params[:user_id]}"
  end 

  private 

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 
end 