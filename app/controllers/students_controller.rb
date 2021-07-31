class StudentsController < ApplicationController
  before_action :authenticate_student!

  def show
    @student_profile = current_student.student_profile
    @notifications = current_student.notifications
    if current_student.pharmacists
      if current_student.relationships.find_by(allow: true)
        @approved_pharmacists = Pharmacist.eager_load(:relationships, :pharmacist_profile).where(relationships: { student_id: current_student.id, allow: true })
      end
      if current_student.relationships.find_by(allow: false)
        @not_approved_pharmacists = Pharmacist.eager_load(:relationships, :pharmacist_profile).where(relationships: { student_id: current_student.id, allow: false })
      end
    end
  end
end
