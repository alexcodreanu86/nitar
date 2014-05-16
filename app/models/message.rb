class Message < ActiveRecord::Base
  validates :sender_email, :subject, :content, presence: true
end
