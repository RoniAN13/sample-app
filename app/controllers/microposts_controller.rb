class MicropostsController < ApplicationController
include SessionsHelper
    before_action :logged_in_user, only: [:create, :destroy , :upvote, :downvote]
    before_action :correct_user, only: :destroy
    before_action :set_post , only: [:upvote, :downvote]

    def create
        @micropost = current_user.microposts.build(micropost_params)
        @micropost.image.attach(params[:micropost][:image])
        if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
        else
         @feed_items = current_user.feed.paginate(page: params[:page])
        render 'static_pages/home'
        end
    end    
    def destroy
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
    end
    def upvote
        
        if !current_user.liked? @micropost
            @micropost.liked_by current_user
        
            
        elsif current_user.liked? @micropost
            @micropost.unliked_by current_user  
        
        end    
        
    end  
    def downvote
        if !current_user.disliked? @micropost
            @micropost.disliked_by current_user
            
        elsif current_user.disliked? @micropost
            @micropost.undisliked_by current_user
         
        end  
       
    end         
     
     private
        def micropost_params
            params.require(:micropost).permit(:content, :image)
        end
        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url if @micropost.nil?
        end
        def set_post
            @micropost = Micropost.find(params[:id])
         end
            
end
