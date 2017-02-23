class Event < ApplicationRecord   belongs_to :user 
  has_many :messages 
  validates :date, presence: true 
  validates :name, presence: true 
  validates :location, presence: true
 end