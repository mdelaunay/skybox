# encoding: UTF-8

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      flash[:success] = "Authentification réussie."
      redirect_to root_path
    else
      flash.now[:error] = "Erreur d'authentification."
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    flash[:success] = "Déconnexion réussie."
    redirect_to login_path
  end

end
