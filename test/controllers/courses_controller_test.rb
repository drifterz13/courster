require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get courses" do
    sign_in users(:user1)
    get courses_url
    assert_response :success
  end

  test "should render new course form" do
    sign_in users(:user1)
    get new_course_url
    assert_response :success
  end

  test "should create course" do
    sign_in users(:user1)
    assert_difference('Course.count', 1) do
      post courses_url, params: { course: { title: 'New course', description: 'New course description' } }
    end
    assert_redirected_to courses_path
    assert_equal 'Course was successfully created.', flash[:notice]
  end
  
  test "should not allow to create course without login" do
    post courses_url, params: { course: { title: 'New course', description: 'New course description' } }
    assert_redirected_to new_session_url
  end

  test "should render edit course form" do
    sign_in users(:user1)
    course = courses(:course1)
    get edit_course_url(course)
    assert_response :success
  end

  test "should update course" do
    sign_in users(:user1)
    course = courses(:course1)
    patch course_url(course), params: { course: { title: 'Updated title', description: 'Updated description' } }
    assert_redirected_to courses_path
    assert_equal 'Course was successfully updated.', flash[:notice]
    course.reload
    assert_equal 'Updated title', course.title
  end

  test "should delete course, given current user is course's author" do
    sign_in users(:user1)
    course = courses(:course1)
    assert_difference('Course.count', -1) do
      delete course_url(course)
    end
    assert_redirected_to courses_path
    assert_equal 'Course was successfully deleted.', flash[:notice]
  end

  test "should not delete course, given current user is not course's author" do
    sign_in users(:user2)
    course = courses(:course1)
    assert_no_difference('Course.count') do
      delete course_url(course)
    end
    assert_redirected_to courses_path
    assert_equal 'You are not authorized to delete this course.', flash[:alert]
  end
end
