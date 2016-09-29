class Admin::UsersController < Admin::BaseController
  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).page(params[:page])
      .per Settings.user_per_page
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        format.json {render json: {status: :ok}}
      else
        flash[:danger] = t ".fail"
        format.js {render js: "window.location = '#{admin_users_path}';"}
      end
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :admin
  end
end
