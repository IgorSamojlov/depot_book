class SessionController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    if User.count == 0
      user = User.new
      user.name = params[:name]
      user.password = params[:password]
      user.save
    end
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: 'Неверные данные'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: 'Сеанс работы завершен'
  end
end
