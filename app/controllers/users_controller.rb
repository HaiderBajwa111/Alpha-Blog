class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy ]
  before_action :user_params, only: [:create, :update]
  before_action :require_user, only: [:show, :edit, :update]
  before_action :check_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new()
  end

  def create
   @user = User.new(user_params)
   if @user.save
    session[:user_id] = @user.id
    flash[:notice] = "Welcome to Alpha-blog, You have successfully signed up"
    redirect_to articles_path
   else
    render 'new'
   end
  end
  
  def edit
    
  end 

  def update
    if @user.update(user_params)
      flash[:notice] = "Updated Successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show 
    @articles = @user.articles
  end

  def index
    @users = User.all
  end

    def destroy
      @user.destroy
      session[:user_id]= nil if @user == current_user
      flash[:notice]= "Accout is successfully deleted"
      redirect_to root_path
    end
  private 
  def user_params
    params.require(:user).permit( :username, :email, :password)
  end
  def find_user
    @user = User.find(params[:id])
  end
  def check_same_user
    if current_user != @user && !current_user.admin?
      flash[:notice] = "You can edit or delete your own articles"
      redirect_to @user
    end
  end

end