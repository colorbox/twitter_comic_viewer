class Tweet < ApplicationRecord
  belongs_to :comic
  has_many :media, dependent: :destroy
end
