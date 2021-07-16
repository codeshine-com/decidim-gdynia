Decidim::Debates::DebatesController.class_eval do
  before_action :destroy_debate, only: :close

  private

  def destroy_debate
    enforce_permission_to :close, :debate, debate: debate

    if params[:delete] == 'true' && debate.allowed_to_destroy?
      debate.destroy
      flash[:notice] = I18n.t("debates.delete.success", scope: "decidim.debates")
      redirect_to action: :index
    end
  end

end
