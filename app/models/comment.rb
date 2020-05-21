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
#  owner_id       :bigint           not null
#
class Comment < ApplicationRecord
  attr_accessor :owner_id

  validates :content, :owner_id, presence: true

  belongs_to :imageable,
      polymorphic: true

  belongs_to :writer
end
