class UsersController < ApplicationController
           def show
             @user = User.find(params[:id])
             @posts = @user.posts
           end

           def index
             @users = User.all
           end
           
           def new
            @user = User.new
           end

           def edit
            @user = User.find(params[:id])
           end

           def update
            @user = User.find(params[:id])
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
                flash[:notice] = "Welcome to the SocialApp #{@user.username}, you have successfully signed up"
                redirect_to @user
            else
                render :new, status: :unprocessable_entity
            end
           end

           private

           def user_params
               params.require(:user).permit(:username, :email, :password)
           end
end