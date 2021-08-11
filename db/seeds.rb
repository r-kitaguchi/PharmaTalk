# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

pharmacist = Pharmacist.create!(
  email: "sample@sample.com",
  password: "password",
  password_confirmation: "password"
)

pharmacist.create_pharmacist_profile!(
  name: "田中太郎",
  image:File.open("./db/fixtures/sample1.png"),
  work_place: "田中薬局",
  work_place_type: 1,
  work_location: 1,
  university: "東京大学",
  introduction: "田中です。よろしくお願いします！"
)

student = Student.create!(
  email: "student@sample.com",
  password: "password",
  password_confirmation: "password"
)

student.create_student_profile!(
  name: "佐藤次郎",
  image:File.open("./db/fixtures/sample2.png"),
  university: "大阪大学",
  year: 1,
  introduction: "佐藤です。よろしくお願いします。"
)

second_student = Student.create!(
  email: "second_student@sample.com",
  password: "password",
  password_confirmation: "password"
)

second_student.create_student_profile!(
  name: "小林健一郎",
  university: "京都大学",
  year: 0,
  introduction: "小林です。よろしくお願いします。"
)

300.times do |n|
  email = Faker::Internet.email

  Pharmacist.create!(
    email: email,
    password: "password",
    password_confirmation: "password"
  )
end

Pharmacist.where(id: 2..101).each do |pharmacist|
  name = Gimei.kanji
  work_location = Faker::Number.between(from:1, to:47)

  pharmacist.create_pharmacist_profile!(
    name: name,
    work_place: "サンプル薬局",
    work_place_type: 0,
    work_location: work_location,
    university: "サンプル大学",
    introduction: "#{name}です。よろしくお願いします！"
  )
end

Pharmacist.where(id: 102..201).each do |pharmacist|
  name = Gimei.kanji
  work_location = Faker::Number.between(from:1, to:47)

  pharmacist.create_pharmacist_profile!(
    name: name,
    work_place: "サンプルドラッグ",
    work_place_type: 1,
    work_location: work_location,
    university: "サンプル大学",
    introduction: "#{name}です。よろしくお願いします！"
  )
end

Pharmacist.where(id: 202..301).each do |pharmacist|
  name = Gimei.kanji
  work_location = Faker::Number.between(from:1, to:47)

  pharmacist.create_pharmacist_profile!(
    name: name,
    work_place: "サンプル病院",
    work_place_type: 2,
    work_location: work_location,
    university: "サンプル大学",
    introduction: "#{name}です。よろしくお願いします！"
  )
end

student.relationships.create!(
  pharmacist_id: 1,
  allow: true
)

second_student.relationships.create!(
  pharmacist_id: 1,
  allow: true
)
