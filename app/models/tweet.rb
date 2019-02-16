class Tweet < ApplicationRecord
  belongs_to :comic
  has_many :media, dependent: :destroy

  def ordered_media
    media.order(id: :asc)
  end
end
