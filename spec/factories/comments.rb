# == Schema Information
#
# Table name: comments
#
#  id             :bigint           not null, primary key
#  content        :text             not null
#  imageable_type :string
#  imageable_id   :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           default(1), not null
#
FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.words(number: 15).join(" ") }
  end
end
