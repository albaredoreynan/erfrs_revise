class UsersController < ApplicationController
  respond_to :html  

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User was successfully created.'
      redirect_to users_path
    else
      flash[:error] = 'An error occured while creating new user.'
      render 'new'
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = 'User updated successfully.'
      redirect_to users_path
    else
      flash[:error] = 'An error occured while updating the user'
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    flash[:success] = 'User has been deleted.' 
    redirect_to users_path
  end


  private
    def user_params
      params.require(:user).permit(:email, :username, :first_name, :last_name, :password, :password_confirmation)
    end

end
