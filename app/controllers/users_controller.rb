class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(:name)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url,
        notice: "User with name #{@user.name} created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if check_and_update
        format.html { redirect_to users_url, notice: "User with name #{@user.name} updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @user.destroy
      flash[:notice] = "Пользователь #{@user.name} удален"
      rescue StandardError => e
        flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def check_and_update
    have_pass = user_params[:password].present? || user_params[:password_confirmation].present?
    @user_for_check = @user.dup
    @user.assign_attributes user_params
    user_valid = @user.valid?

    if have_pass ? @user_for_check.authenticate(params[:user][:password_check]) && user_valid : user_valid
      @user.save
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
