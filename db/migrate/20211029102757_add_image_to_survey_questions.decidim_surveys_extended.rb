# This migration comes from decidim_surveys_extended (originally 20211029101633)
class AddImageToSurveyQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_forms_questions, :question_image, :string
  end
end
