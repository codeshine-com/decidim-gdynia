# This migration comes from decidim_surveys_extended (originally 20210810154724)
class AddAdditionalFieldsToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_forms_questions, :metrics, :string
  end
end
