Decidim::AccountController.class_eval do

  def show
    enforce_permission_to :show, :user, current_user: current_user
    @account = form(Decidim::AccountForm).from_model(current_user)
    if params[:pass] == 'true'
      render 'pass_change'
    else
      render 'show'
    end
  end

  def update
    enforce_permission_to :update, :user, current_user: current_user
    @account = form(Decidim::AccountForm).from_params(account_params)

    Decidim::UpdateAccount.call(current_user, @account) do
      on(:ok) do |email_is_unconfirmed|
        flash[:notice] = if email_is_unconfirmed
                           t("account.update.success_with_email_confirmation", scope: "decidim")
                         else
                           t("account.update.success", scope: "decidim")
                         end

        bypass_sign_in(current_user)
        redirect_to account_path
      end

      on(:invalid) do
        flash[:alert] = t("account.update.error", scope: "decidim")
        if params[:pass] == 'true'
          render 'pass_change'
        else
          render 'show'
        end
      end
    end
  end
end
