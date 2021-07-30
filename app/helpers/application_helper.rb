module ApplicationHelper
  def no_one_is_logged_in
    !pharmacist_signed_in? && !student_signed_in?
  end
end
