class CommentsController < ApplicationController

  def create
    @comment = @commentable.comments.build(body: comment_params['body'], user_id: current_user.id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable.is_a?(Book) ? book_path(@commentable) : report_path(@commentable), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else 
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
