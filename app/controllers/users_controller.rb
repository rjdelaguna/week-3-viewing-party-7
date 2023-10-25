class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path 
      flash[:error] = "Must be logged in."
    end
  end 

  def create 
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.name}!"
      if new_user.admin?
        redirect_to admin_dashboard_path
      elsif new_user.manager?
        redirect_to root_path
      else
        redirect_to root_path
      end
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
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      if user.admin?
        redirect_to admin_dashboard_path
      elsif user.manager?
        redirect_to root_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 