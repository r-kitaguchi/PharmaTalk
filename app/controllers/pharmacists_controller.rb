class PharmacistsController < ApplicationController
  before_action :authenticate_pharmacist!

  def show
    @pharmacist_profile = current_pharmacist.pharmacist_profile
    @notifications = current_pharmacist.notifications
    @approved_students = Student.eager_load(:relationships, :student_profile).where(relationships: { pharmacist_id: current_pharmacist.id, allow: true })
    current_pharmacist.relationships.find_by(allow: false)
    @not_approved_students = Student.eager_load(:relationships, :student_profile).where(relationships: { pharmacist_id: current_pharmacist.id, allow: false })
  end
end
