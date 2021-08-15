Decidim::Surveys::Admin::SurveysController.class_eval do
  after_action :let_me_see, only: :update

  def let_me_see
    # p 'updateupdateupdateupdate'
    # p @form.errors.inspect
  end


end
