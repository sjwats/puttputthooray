class AppController < ApplicationController
  before_action :authenticate_user!

  before_action :redirect_if_profile_incomplete

  private

  def super_admin_only
    unless current_user.has_super_admin_privilege?
      redirect_to root_path
    end
  end

  def admin_only
    unless current_user.has_admin_privilege?
      redirect_to root_path
    end
  end

  def redirect_if_profile_incomplete
    return true if current_user.role == RoleType.CO.code
    unless current_user.profile_complete?
      flash[:alert] = "Please complete your profile"
      redirect_to root_path
    end
  end

end
