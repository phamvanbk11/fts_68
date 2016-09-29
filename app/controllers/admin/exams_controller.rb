class Admin::ExamsController < Admin::BaseController
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
