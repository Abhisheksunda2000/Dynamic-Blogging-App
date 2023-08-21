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

    def search
        search_query = params[:query].downcase
    
        # Search articles based on title, topic, or user.
        @posts = Post.where("LOWER(title) LIKE ? OR LOWER(topic) LIKE ? OR LOWER(author) LIKE ?", "%#{search_query}%", "%#{search_query}%", "%#{search_query}%")
    
        render json: @posts
    end

    def recommended_posts
        user = current_user
        interested_topics = user.profile.interested_topics
        @recommended_posts = Post.where(topic: interested_topics)

        render json: @recommended_posts, status: :ok
    end
    
    def top_posts
        @top_posts = Post.order(post_likes: :desc, post_comments: :desc).limit(5)

        render json: @top_posts, status: :ok
    end

    def posts_by_topic
        @posts = Post.where(topic: params[:topic])

        render json: @posts, status: :ok
    end

    def drafts
        @posts = Post.draft

        render json: @posts, status: :ok
    end

    def revisions
        @post = Post.find(params[:id])
        @revisions = @post.post_revisions
        render json: @revisions
    end
    
    def save_for_later
        post = Post.find(params[:id])
        current_user.saved_posts.create(post: post)
        render json: current_user.saved_posts
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