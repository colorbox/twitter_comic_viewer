class User < ApplicationRecord
  has_many :comics, dependent: :destroy
end
