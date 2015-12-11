class Message < ActiveRecord::Base
  validates :name , length: { maximum: 10 } , presence: true
  validates :body , length: { minimum: 2, maximum: 32 } , presence: true
end
