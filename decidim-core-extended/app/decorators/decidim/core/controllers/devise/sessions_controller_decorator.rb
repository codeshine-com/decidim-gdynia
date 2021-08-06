# frozen_string_literal: true

Decidim::Devise::SessionsController.class_eval do

  def after_sign_in_path_for(user)
    if user.present? && user.blocked?
      check_user_block_status(user)
    elsif user.present? && !user.confirmed?
      check_user_conformation_status(user)
    elsif first_login?(user)
      flash.delete(:notice)
      flash[:notice] = t("decidim.account.fill_more_data")
      decidim.account_path
    elsif first_login_and_not_authorized?(user) && !user.admin? && !pending_redirect?(user)
      decidim_verifications.first_login_authorizations_path
    else
      super
    end
  end

  def first_login?(user)
    user.is_a?(Decidim::User) && user.sign_in_count == 1
  end

  def check_user_conformation_status(user)
    if user.present? && !user.confirmed?
      sign_out user
      flash.delete(:notice)
      flash[:error] = t("decidim.account.not_confirmed")
      root_path
    end
  end
end
