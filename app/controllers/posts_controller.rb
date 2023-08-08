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

    def edit
        @posts = Post.find(params[:id])
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

    # if @article.update(params.require(:article).permit(:title, :description))

    def update
        @posts = Post.find(params[:id])
        if @posts.update(params.require(:post).permit(:title, :topic, :text))
            flash[:notice] = "Post was updated successfully"
            redirect_to @posts
        else
            render 'edit'
        end
    end  
    
    def destroy
        @posts = Post.find(params[:id])
        @posts.destroy
        redirect_to post_path, status: :see_other
    end
end