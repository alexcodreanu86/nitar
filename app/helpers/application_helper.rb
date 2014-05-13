module ApplicationHelper
  def current_admin?
    current_user && current_user.is_admin
  end
end
