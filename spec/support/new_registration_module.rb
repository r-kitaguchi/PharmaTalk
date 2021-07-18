module NewRegistrationModule
  def pharmacist_registration(email, password, password_confirmation)
    visit new_pharmacist_registration_path
    fill_in "pharmacist_email", with: email
    fill_in "pharmacist_password", with: password
    fill_in "pharmacist_password_confirmation", with: password_confirmation
    click_on "メールアドレスで登録"
  end

  def student_registration(email, password, password_confirmation)
    visit new_student_registration_path
    fill_in "student_email", with: email
    fill_in "student_password", with: password
    fill_in "student_password_confirmation", with: password_confirmation
    click_on "メールアドレスで登録"
  end
end
