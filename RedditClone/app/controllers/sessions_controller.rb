class SessionsController < ApplicationController

    before_action :ensure_login, only: [:destroy]

    def create
        @user = User.find_by_c(params[:user][:username], params[:user][:password])
        if @user && @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ["Invalid Username or Password"]
            render :new
        end
    end

    def new
        render :new
    end

    def destroy
        logout
        redirect_to new_session_url
    end
end