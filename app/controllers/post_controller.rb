class PostController < ApplicationController
    
    def show
        @posts = Post.find(params[:id])
    end
    
    def index
        @posts = Post.all
    end

    
end