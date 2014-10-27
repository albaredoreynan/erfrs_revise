class UsersController < ApplicationController
  respond_to :html  

  def index
    @hide_nav = true
    
    @users = User.all.paginate(page: params[:page],per_page: 30)
  end

  def new
  
    @hide_nav = true
    @user = User.new
  end

  def edit
    @hide_nav = true
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
      params.require(:user).permit(:email, :username, :first_name, :last_name, :password, :password_confirmation, :region_id, :municipality_id, :barangay_id, :province_id, :role_id)
    end
end

