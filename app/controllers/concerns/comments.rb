# frozen_string_literal: true

module Comments
  # TODO: エラー発生原因を特定する
  # extend ActiveSupport::Concernを削除すると、
  # included do で「wrong number of arguments (given 0, expected 1)」が発生する
  extend ActiveSupport::Concern

  included do
    before_action :set_commentable
  end

  def create
    @comment = @commentable.comments.build(comment_params)

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_commentable
    raise NotImplementedError, 'set_commentable(privateメソッド)を実装する。@commentableにコメント対象のオブジェクトを格納する'
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
