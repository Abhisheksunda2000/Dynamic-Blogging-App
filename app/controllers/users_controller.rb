class UsersController < ApplicationController
            before_action :set_user, only: [:show, :edit, :update, :destroy]
            before_action :require_user, only: [:edit, :update]
            before_action :require_same_user, only: [:edit, :update, :destroy]

            def show  
             @posts = @user.posts.paginate(:page => params[:page], :per_page => 1)
           end

           def index
             @users = User.paginate(:page => params[:page], :per_page => 2)
           end
           
           def new
            @user = User.new
           end

           def edit
           end

           def update
            if(@user.update(user_params))
                flash[:notice] = "You have successfully updated the signed in info"
                redirect_to user_path
            else 
                render 'edit'
            end
           end

           def create
            @user = User.new(user_params)
            if(@user.save)
                session[:user_id] = @user.id
                flash[:notice] = "Welcome to the SocialApp #{@user.username}, you have successfully signed up"
                redirect_to @user
            else
                render :new, status: :unprocessable_entity
            end
           end

           def destroy
            @user.destroy
            session[:user_id] = nil
            flash[:notice] = "Account and all associated posts successfully deleted"
            redirect_to root_path
           end

           private

           def user_params
               params.require(:user).permit(:username, :email, :password)
           end

           def set_user
               @user = User.find(params[:id])
           end

           def require_same_user
            if current_user != @user
              flash[:alert] = "You can only edit your own account"
              redirect_to @user
            end
          end
end