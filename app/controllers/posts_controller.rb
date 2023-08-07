class PostsController < ApplicationController
    
    def show
        @posts = Post.find(params[:id])
    end
    
    def index
        @posts = Post.all
    end

    def new
        @posts = Post.new()
    end

    def create
         @posts = Post.new(params.require(:posts).permit(:title, :topic, :text))
         if @posts.save
           flash[:notice] = "Post was created successfully"
           redirect_to @posts
         else 
            render :new, status: :unprocessable_entity
         end    
    end

    
end