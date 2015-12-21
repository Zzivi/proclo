class Recipe < ActiveRecord::Base
  before_save { self.name = name.downcase }
  validates :name, presence: true, length: { maximum: 100 },
            uniqueness: { case_sensitive: false }
  enum level: [:easy, :medium, :difficult]
  validates :time, presence: true, numericality: {only_integer: true}
end
