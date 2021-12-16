module UsersHelper

  def is_admin?
    unless current_user.is_admin
      flash[:danger] = "Accès refusé. Vous n'êtes pas administrateur de ce site ⛔"
      redirect_to root_path
    end
  end

end
