class QuestionsController < ApplicationController
  before_action :load_subjects
  load_and_authorize_resource

  def index
    @questions = @questions.suggested(current_user).page(params[:page])
      .per Settings.question_per_page
  end

  def new
    @question = Question.new question_type: :text
    @question.answers.build is_correct: true
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash[:success] = t ".success"
      redirect_to user_questions_path current_user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t ".success"
      redirect_to user_questions_path current_user
    else
      render :edit
    end
  end

  def destroy
    if @question.valid_to_delete?
      if @question.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".error"
      end
    else
      flash[:danger] = t ".fail"
    end
    redirect_to user_questions_path current_user
  end

  private
  def load_subjects
    @subjects = Subject.alphabet
  end

  def question_params
    params.require(:question).permit :subject_id, :content, :question_type,
      :state, :user_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

end
