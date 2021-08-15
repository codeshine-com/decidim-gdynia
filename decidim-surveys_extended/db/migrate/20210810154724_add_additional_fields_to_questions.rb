class AddAdditionalFieldsToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_forms_questions, :metrics, :string
  end
end
