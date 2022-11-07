class Message < ApplicationRecord
  before_create :confirm_participant
  belongs_to :user
  belongs_to :chatroom
  validates :content, presence: true
  after_create_commit { broadcast_append_to self.chatroom }
  def confirm_participant
    if self.chatroom.is_private
      is_participant = Participant.where(user_id: self.user.id, chatroom_id: self.chatroom.id).first
      throw :abort unless is_participant
    end
  end
end
