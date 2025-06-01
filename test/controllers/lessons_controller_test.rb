require "test_helper"

class LessonsControllerTest < ActionDispatch::IntegrationTest
  test "should render form to create a lesson for course" do
    sign_in users(:one)
    get new_course_lesson_url(courses(:one))
    assert_response :success
  end

  test "should create lesson for course" do
    sign_in users(:one)
    course = courses(:one)

    assert_difference('Course.with_lessons(course.id).lessons.count', 1) do
        post course_lessons_url(course), params: { lesson: { title: 'New Lesson', description: 'Lesson content' } }
    end
    assert_redirected_to course_path(course)
  end

  test "should create lesson with learning material" do
    sign_in users(:one)
    course = courses(:no_lessons)

    assert_difference('Course.with_lessons(course.id).lessons.count', 1) do
        post course_lessons_url(course), params: { 
          lesson: { 
            title: 'New Lesson',
            description: 'Lesson content',
            learning_material_attributes: { title: 'New video', file_url: 'https://example.com/video.mp4' 
            }
          },
        }
    end

    course.reload
    assert_equal 'New video', course.lessons.first.learning_material.title
    assert_redirected_to course_path(course)
  end

  test "should not allow to create lesson without login" do
    course = courses(:one)
    post course_lessons_url(course), params: { lesson: { title: 'New Lesson', description: 'Lesson content', order: 1 } }
    assert_redirected_to new_session_url
  end

  test "should delete lesson, given current user is course's author" do
    sign_in users(:one)
    course = courses(:one)
    assert_difference('course.lessons.count', -1) do
      delete course_lesson_url(course, course.lessons.first)
    end

    assert_redirected_to course_path(course), notice: 'Lesson was successfully deleted.'
  end

  test "should not delete lesson, given current user is not course's author" do
    sign_in users(:two)
    course = courses(:one)
    assert_no_difference('course.lessons.count') do
      delete course_lesson_url(course, course.lessons.first)
    end

    assert_redirected_to course_path(course), alert: 'You are not authorized to delete this lesson.'
  end
end
