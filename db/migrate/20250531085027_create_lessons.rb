class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.integer :order, null: false
      t.integer :course_id

      t.timestamps
    end

    add_index :lessons, :course_id, name: 'index_lessons_on_course_id'
    add_foreign_key :lessons, :courses, column: :course_id
  end
end
