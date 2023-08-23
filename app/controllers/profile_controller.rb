class ProfilesController < ApplicationController
    before_action :set_user, only: [:show, :follow, :unfollow]

    def create_profile
        @profile = current_user.build_profile(profile_params)
        if @profile.save
            render json: @profile
        else
            render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        render json: @user.profile
    end

    def my_profile
        render json: current_user.profile
    end
    
    def follow
        unless current_user.following?(@user)
          current_user.follow(@user)
          render json: "Following user"
        else
          render json: "Already following user", status: :unprocessable_entity
        end
    end

    def unfollow
        if current_user.following?(@user)
          current_user.unfollow(@user)
          render json: "Unfollowing user"
        else
          render json: "Not following user", status: :unprocessable_entity
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def profile_params
        params.permit(:bio, :name, :interested_topics, :save_for_later)
    end
end
