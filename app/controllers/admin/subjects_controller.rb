class Admin::SubjectsController < Admin::BaseController
  def index
    @q = Subject.ransack params[:q]
    @subjects = @q.result(distinct: true).updated_desc.page(params[:page])
      .per Settings.subject_per_page
  end

  def new
    @subject = Subject.new
    respond_to do |format|
      format.html {render layout: false, partial: "form",
        locals: {subject: @subject, button_text: t("create"),
        title_text: t(".new_subject") }}
    end
  end

  def create
    @subject = Subject.new subject_params
    respond_to do |format|
      if @subject.save
        flash[:success] = t ".success"
        format.js {render js: "window.location = '#{admin_subjects_path}';"}
      else
        format.json {render json: @subject.errors,
          status: :unprocessable_entity}
      end
    end
  end

  def edit
    respond_to do |format|
      format.html {render layout: false, partial: "form",
        locals: {subject: @subject, button_text: t("edit"),
        title_text: t(".edit_subject") }}
    end
  end

  def update
    respond_to do |format|
      if @subject.update_attributes subject_params
        flash[:success] = t ".success"
        format.js {render js: "window.location = '#{admin_subjects_path}';"}
      else
        format.json {render json: @subject.errors,
          status: :unprocessable_entity}
      end
    end
  end

  def destroy
    if @subject.valid_to_delete?
      if @subject.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".error"
      end
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      :number_of_questions, :duration
  end
end
