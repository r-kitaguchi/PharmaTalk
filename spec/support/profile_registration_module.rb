module ProfileRegistrationModule
  def pharmacist_profile_registration
    visit new_pharmacist_profile_path
    fill_in "pharmacist_profile_name", with: pharmacist_profile.name
    image_path = Rails.root.join('spec/fixtures/test.jpg')
    attach_file("pharmacist_profile_image", image_path)
    fill_in "pharmacist_profile_work_place", with: pharmacist_profile.work_place
    choose "pharmacist_profile_work_place_type_調剤薬局"
    fill_in "pharmacist_profile_university", with: pharmacist_profile.university
    fill_in "pharmacist_profile_introduction", with: pharmacist_profile.introduction
    click_on "登録"
  end

  def student_profile_registration
    visit new_student_profile_path
    fill_in "student_profile_name", with: student_profile.name
    image_path = Rails.root.join('spec/fixtures/test.jpg')
    attach_file("student_profile_image", image_path)
    fill_in "student_profile_university", with: student_profile.university
    choose "student_profile_year_５年"
    fill_in "student_profile_introduction", with: student_profile.introduction
    click_on "登録"
  end
end
