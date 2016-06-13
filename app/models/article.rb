class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	# TIPS	: las validaciones van en el modelo.
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }
	before_save :set_visits_count

	has_attached_file :cover, styles: { } # ESTO VA EN STYLES PERO DA ERROR medium: "1280x720", thumb: "800x600"
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	private

	def set_visits_count
		self.visits_count ||= 0			
	end

end
