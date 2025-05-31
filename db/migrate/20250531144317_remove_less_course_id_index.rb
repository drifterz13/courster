class RemoveLessCourseIdIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :lessons, name: 'index_lessons_on_course_id'
  end
end
