# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  title       :string           not null
#  description :text             not null
#  private     :boolean          default(FALSE)
#  completed   :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :task do
      title { Faker::Lorem.words(3).join(" ") }
      description { Faker::Lorem.words(6).join(" ") }
  end
end
