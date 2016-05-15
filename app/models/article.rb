# --------------------- NODELO --------------------------

class Article < ActiveRecord::Base
	# TIPS: las validaciones van en el modelo.
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }
end
