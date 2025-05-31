class CreateLearningMaterials < ActiveRecord::Migration[8.0]
  def change
    create_table :learning_materials do |t|
      t.string :title
      t.string :material_type
      t.string :file_url
      t.integer :lesson_id

      t.timestamps
    end

    add_index :learning_materials, :lesson_id, name: 'index_learning_materials_on_lesson_id'
    add_foreign_key :learning_materials, :lessons, column: :lesson_id
  end
end
