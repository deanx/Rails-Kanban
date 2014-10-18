class Change < ActiveRecord::Base
  belongs_to :story
  belongs_to :user
  belongs_to :state_from, :class_name => "State"
  belongs_to :state_to, :class_name => "State"

  validates :story, presence: true
  validates :user, presence: true
  validates :state_from, presence: true
  validates :state_to, presence: true

  def execution_time
    Change.all.each do |change|
    end
  end
end
