# encoding: UTF-8

class UsersController < ApplicationController

  def new
    @user ||= User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Compte créé avec succès. Vous pouvez vous identifier."
      redirect_to login_path
    else
      flash.now[:error] = "Erreur de création du compte."
      parse_error_messages(@user)
      render :new
    end
  end


end
