class LikesController < ApplicationController
     before_action :find_post
     before_action :find_like, only: [:destroy]
     
     def create
        if already_liked?
          flash[:notice] = "You can't like more than once"
        else
          @posts.likes.create(user_id: current_user.id)
        end
        redirect_to @posts
    end

    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @like.destroy
        end
        redirect_to @posts
    end

     private

     def find_post
          @posts = Post.find(params[:post_id])     
     end

     def already_liked?
        Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end

    def find_like
        @like = @posts.likes.find(params[:id])
     end
end
