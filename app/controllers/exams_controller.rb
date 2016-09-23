class ExamsController < ApplicationController
  before_action :authenticate_user!
  def create
    @exam = Exam.new exam_params
    if @exam.save
      flash[:success] = t "alert_create_exam_success"
    else
      flash[:danger] = t "alert_create_exam_fail"
    end
    redirect_to root_path
  end

  def index
    @exam = current_user.exams.new
    @subjects = Subject.all
    @exams = current_user.exams.page(params[:page]).per Settings.exam_per_page
  end

  private
  def exam_params
    params.require(:exam).permit(:subject_id).merge! user: current_user
  end
end
