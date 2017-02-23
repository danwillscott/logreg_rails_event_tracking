class Message < ApplicationRecord
  belongs_to :user, inverse_of: :messages
  belongs_to :event, inverse_of: :messages





end
