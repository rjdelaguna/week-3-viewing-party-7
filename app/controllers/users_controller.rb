class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    if new_user.save
      flash[:success] = "Welcome, #{new_user.name}!"
      redirect_to user_path(new_user)
    else  
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user != nil && user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 