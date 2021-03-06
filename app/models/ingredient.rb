class Ingredient < ActiveRecord::Base
	before_save { self.name = name.downcase }
	validates :name, presence: true, length: { maximum: 50 },
            uniqueness: { case_sensitive: false }
	enum measurement_type: [:liquid, :weight, :unit]
end
