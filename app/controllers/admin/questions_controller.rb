class Admin::QuestionsController < ApplicationController
  include Admin::QuestionsHelper
  load_and_authorize_resource

  def index
    params[:q] = {} if params[:q].nil?
    @subjects = Subject.all
    @questions_types = mapping_enum_to_i18n :question_type,
      Question.question_types
    @states = mapping_enum_to_i18n :state, Question.states
    @q = Question.ransack params[:q]
    @questions = @q.result(distinct: true).page(params[:page])
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
end
