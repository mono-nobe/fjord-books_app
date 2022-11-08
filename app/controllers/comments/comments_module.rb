# frozen_string_literal: true

module Comments
    def create
        @comment = @commentable.comments.build(comment_params)

        respond_to do |format|
          if @comment.save
            format.html { redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      private

      # Only allow a list of trusted parameters through.
      def comment_params
        params.require(:comment).permit(:body).merge(user_id: current_user.id)
      end
end
