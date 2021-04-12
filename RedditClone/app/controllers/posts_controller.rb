class PostsController < ApplicationController

    before_action :find_author, only: [:edit, :update]
    def new 
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        if @post
            @post.save
        else
            flash[:errors] = ["error"]
            render :new
        end
    end

    def show
        @post = Post.find(params[:id])
        render :show
    end

    def eidt
        @post = Post.find(params[:id])
        render :edit
    end

    def update
        @post = Post.find(params[:id])
        if @post
            @post.update
            redirect_to post_url(@post)
        else
            flash[:errors] = ["can not find post"]
            render :new
        end
    end

    def destroy
        @post = Post.find(params[:id])
        if @post
            @post.destroy
            redirect_to sub_url(@post.sub_id)
        else
            flash[:errors] = ["can not find post to destroy"]
            render :new
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :url, :content,:sub_id)
    end

    def find_author
        if current_user.posts.find_by[author_id: params[:author_id]]
            return
        else
            render json: "error", status: :forbiden
        end
    end


end