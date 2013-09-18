class Message < ActiveRecord::Base
  default_scope order: 'messages.created_at DESC'

  attr_accessible :content, :to

  belongs_to :user

  validates :user_id,   presence: true
  validates :content,   presence: true
  validates :to     ,   presence: true

  def self.messages_to(user)
    where(to:  user.id)
  end
end
