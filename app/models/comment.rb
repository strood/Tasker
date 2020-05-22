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
class Comment < ApplicationRecord
  attr_accessor :user_id

  validates :content, :user_id, presence: true

  belongs_to :imageable,
      polymorphic: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end
