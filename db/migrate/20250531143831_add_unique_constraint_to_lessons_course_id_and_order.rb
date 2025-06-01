class AddUniqueConstraintToLessonsCourseIdAndOrder < ActiveRecord::Migration[8.0]
  def change
    add_index :lessons, [ :course_id, :order ], unique: true, name: 'index_lessons_on_course_id_and_order'
  end
end
