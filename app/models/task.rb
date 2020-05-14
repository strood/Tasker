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
class Task < ApplicationRecord
  validates :user_id, :title, :description, presence: true


  def self.find_by_user_id(id)
    @tasks = Task.find_by(user_id: id)
    return nil unless @tasks
    @tasks
  end

end
