class Task < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 32}}
end
