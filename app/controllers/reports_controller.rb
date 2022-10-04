# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  # GET /reports
  def index
    @reports = Report.includes(:user).order(:id).page(params[:page]).per(10)
  end

  # GET /reports/1
  def show
    @comments = @report.comments.order(created_at: :desc)
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
    render html: helpers.tag.strong('Not Found') unless @report.user.id == current_user.id
  end

  # POST /reports
  def create
    @report = current_user.reports.build(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  def update
    return render json: { error: '404 error' }, status: :not_found unless @report.user.id == current_user.id

    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  def destroy
    return render json: { error: '404 error' }, status: :not_found unless @report.user.id == current_user.id

    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:title, :body)
  end
end
