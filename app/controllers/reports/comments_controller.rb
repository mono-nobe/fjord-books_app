# frozen_string_literal: true

require_relative '../concerns/comments_module'

class Reports::CommentsController < ApplicationController
  include Comments

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end
end
