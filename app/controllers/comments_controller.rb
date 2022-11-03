class CommentsController < ApplicationController
    def create
    @comment = current_user.comments.new(comment_params)
    if !@comment.save
        redirect_to root_url
    else
        respond_to do |format|
            format.html { redirect_to root_url }
            format.js
            end
    end

    end
    def destroy
        @micropost = Micropost.find(params[:micropost_id])
        @comment = @micropost.comments.find(params[:id])
        @comment.destroy
        flash[:success] = "Comment deleted"
        redirect_to request.referrer || root_url
    end    
 private
  def comment_params
   params
   .require(:comment)
   .permit(:content, :parent_id)
   .merge(micropost_id: params[:micropost_id])
  end     
end
