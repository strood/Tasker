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
#
class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :imageable,
      polymorphic: true
end
