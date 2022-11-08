# frozen_string_literal: true

require_relative '../comments/comments_module'

class Reports::CommentsController < ApplicationController
  include Comments

  before_action :set_commentable

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end
end
