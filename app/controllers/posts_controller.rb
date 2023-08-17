class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def show
        @comment = @posts.comments.build
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
        @comment = Comment.new(comment_params)
   
        respond_to do |format|
          if @comment.save
            format.html { redirect_to @comment.post, notice: "Comment was successfully created." }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
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
        params.require(:post).permit(:title, :topic, :text, category_ids: [])
    end

    def require_same_user
        if current_user != @posts.user && current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @posts
        end

    end

   
end