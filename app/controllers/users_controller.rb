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
          format.html { redirect_to users_url,
          notice: "User with name #{@user.name} updated." }
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
      if @user.authenticate(params[:user][:password_check])
        return @user.update(user_params)
      elsif params[:user][:password].empty?
        return @user.update(user_params)
      else
        User.transaction do
          @user.update(user_params)
          raise ActiveRecord::Rollback
        end
        @user.errors[:old_password] = 'can`t be blank or doesn`t match Password'
        return false
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
