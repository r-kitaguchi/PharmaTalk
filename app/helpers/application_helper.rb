module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Pharma Talk"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def no_one_is_logged_in
    !pharmacist_signed_in? && !student_signed_in?
  end
end
