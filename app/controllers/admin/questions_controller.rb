class Admin::QuestionsController < ApplicationController
  include Admin::QuestionsHelper
  load_and_authorize_resource
  before_action :load_subjects, except: [:show, :destroy]
  before_action :load_question_types, only: :index

  def index
    params[:q] = {} if params[:q].nil?
    @states = mapping_enum_to_i18n :state, Question.states
    @q = Question.ransack params[:q]
    @questions = @q.result(distinct: true).updated_desc.page(params[:page])
      .per Settings.question_per_page
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
    redirect_to admin_questions_path
  end

  def new
    @question = Question.new question_type: :text
    @question.answers.build is_correct: true
  end

  def create
    if @question.save
      flash[:success] = t ".success"
      redirect_to admin_questions_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t ".success"
      redirect_to admin_questions_path
    else
      render :edit
    end
  end

  private
  def load_subjects
    @subjects = Subject.alphabet
  end

  def load_question_types
    @questions_types = mapping_enum_to_i18n :question_type,
      Question.question_types
  end

  def question_params
    params.require(:question).permit :subject_id, :content, :question_type,
      :state, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
