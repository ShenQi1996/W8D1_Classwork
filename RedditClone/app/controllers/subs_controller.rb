class SubsController < ApplicationController
    before_action :find_moderator, only: [:edit, :update]
    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        if @sub.save
            redirect_to subs_url
        else
            flash[:errors] = ["description and title can not be empty"]
            render new
        end
    end

    def edit
        @sub = Sub.find(params[:id])
        render :edit
    end

    def index
        @subs = Sub.all
        render :index
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def update
        @sub = Sub.find(params[:id])
        if @sub 
            @sub.update
            redirect_to sub_url(@sub)
        else
            flash[:errors] = ["Can not find sub"]
            redirect_to subs_url
        end
    end



    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end


    def find_moderator
        if current_user.subs.find_by(id: params[:id])
            return
        else
            render json: "error", status: :forbiden
        end
    end

    
end