class PostsController < ApplicationController
    
    def show
        @posts = Post.find(params[:id])
    end
    
    def index
        @posts = Post.all
    end

    def new
    end

    def create
    end

    
end