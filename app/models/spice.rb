class Spice < ApplicationRecord
    validates :title, presence: true
    validates :rating, presence: true
end
