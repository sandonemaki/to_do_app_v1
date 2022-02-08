class Task < ApplicationRecord
  validates :content, presence: {message: "タスクの内容を入力してください"}
  validates :content, length: { maximum: 20, message: "タスクの内容は20文字までです" }
end
