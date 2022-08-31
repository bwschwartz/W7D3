class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save!
      login(@user)
      redirect_to
    else
      redirect_to user_url(@user.id)
  ends

  def new
    @user = User.new
    render :new
  end

  def destroy
    # @user = User.find_by(username: params[])
  end

  def show
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end