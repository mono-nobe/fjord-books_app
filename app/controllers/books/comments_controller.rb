# frozen_string_literal: true

require_relative '../comments/comments_module'

class Books::CommentsController < ApplicationController
  include Comments

  before_action :set_commentable

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end
