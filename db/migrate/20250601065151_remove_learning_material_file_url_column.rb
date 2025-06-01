class RemoveLearningMaterialFileUrlColumn < ActiveRecord::Migration[8.0]
  def change
    remove_column :learning_materials, :file_url
  end
end
