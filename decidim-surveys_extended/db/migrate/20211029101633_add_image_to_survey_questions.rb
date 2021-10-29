class AddImageToSurveyQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_forms_questions, :question_image, :string
  end
end
