module GeneralMethodsHelper
  def require_logged_in_user
    unless user_signed_in?
      flash[:danger] = t "require_logged_in"
      redirect_to root_path
    end
  end

  def require_logged_in_as_admin
    unless current_user.admin?
      sign_out
      redirect_to root_path
    end
  end
end
