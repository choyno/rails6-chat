class Message < ApplicationRecord

  belongs_to :message_thread, :inverse_of => :messages
  belongs_to :user, :inverse_of => :messages

  validates_presence_of :content, :message_thread_id, :user_id

end

