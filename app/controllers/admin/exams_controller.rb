class Admin::ExamsController < ApplicationController
  before_action :require_logged_in_user, :require_logged_in_as_admin
  load_and_authorize_resource

  def index
    @exams = @exams.page(params[:page]).per Settings.exam_per_page
  end

  def edit
  end

  def update
    if @exam.update_attributes exam_params
      Chatwork.send_message @exam
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_exams_path
  end


  private
  def exam_params
    params.require(:exam).permit(:state)
  end
end
