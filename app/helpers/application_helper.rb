module ApplicationHelper

  def no_one_is_logged_in
    !pharmacist_signed_in? && !student_signed_in?
  end

  def header_pharmacist_menu(user)
    header_menu(user, user.pharmacist_profile, new_pharmacist_profile_path(user))
  end

  def header_student_menu(user)
    header_menu(user,user.student_profile, new_student_profile_path(user))
  end

  def header_menu(user, user_profile, user_profile_path)
    if !user
      return
    elsif !user_profile
      tag.li link_to "プロフィールを登録",user_profile_path
    elsif user_profile.image?
      tag.li image_tag user_profile.image.url, class: "user_icon"
    else
      tag.li do
        image_tag "/assets/default.png", class: "user_icon default"
      end
    end
  end
end
