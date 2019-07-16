class MessageThread < ApplicationRecord

  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  has_many :messages, dependent: :destroy, :inverse_of => :message_thread


  validates_uniqueness_of :sender_id, scope: :receiver_id

  scope :between, -> (sender_id, receiver_id) do
    where("(message_threads.sender_id = ? AND message_threads.receiver_id = ?) OR (message_threads.receiver_id = ? AND message_threads.sender_id = ?)", sender_id, receiver_id, sender_id, receiver_id)
  end

  def recipient(current_user)
    self.sender_id == current_user.id ? self.receiver : self.sender
  end

end
