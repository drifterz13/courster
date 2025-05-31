class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.integer :author_id

      t.timestamps
    end

    add_index :courses, :author_id, name: 'index_courses_on_author_id'
    add_foreign_key :courses, :users, column: :author_id
  end
end
