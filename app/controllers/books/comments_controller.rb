# frozen_string_literal: true

require_relative '../concerns/comments_module'

class Books::CommentsController < ApplicationController
  include Comments

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end
