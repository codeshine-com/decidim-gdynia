# frozen_string_literal: true

Decidim::UpdateAccount.class_eval do

  private

  def update_personal_data
    @user.name = @form.name
    @user.nickname = @form.nickname
    @user.email = @form.email
    @user.personal_url = @form.personal_url
    @user.about = @form.about
    # custom
    @user.gender = @form.gender
    @user.birth_year = @form.birth_year
    @user.district = @form.district
  end
end
