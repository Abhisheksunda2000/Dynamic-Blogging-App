class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    def show
    end
    
    def index
        @posts = Post.paginate(:page => params[:page], :per_page => 2)
    end

    def new
        @posts = Post.new()
    end

    def edit
    end

    def create
         @posts = Post.new(post_params)
         @posts.user = current_user
         if @posts.save
           flash[:notice] = "Post was created successfully"
           redirect_to @posts
         else 
            render :new, status: :unprocessable_entity
         end    
    end

    # if @article.update(params.require(:article).permit(:title, :description))

    def update
        if @posts.update(post_params)
            flash[:notice] = "Post was updated successfully"
            redirect_to @posts
        else
            render 'edit'
        end
    end  
    
    def destroy
        @posts.destroy
        redirect_to post_path, status: :see_other
    end

    private

    def set_post
        @posts = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :topic, :text)
    end

   
end