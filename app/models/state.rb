class State < ActiveRecord::Base
  validates :title, :presence => true
  validates :order, :presence => true

  def to_s
    self.title
  end
end
