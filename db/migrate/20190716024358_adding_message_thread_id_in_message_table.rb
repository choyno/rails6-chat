class AddingMessageThreadIdInMessageTable < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :message_thread, foreign_key: true
  end
end
