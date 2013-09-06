class Micropost < ActiveRecord::Base
  attr_accessible :content, :in_reply_to_id
  belongs_to :user
  before_save   :is_reply?

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

   def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR in_reply_to_id = :user_id",
          user_id: user.id)
  end

  def self.from_users_replyed_to(user)
    where("in_reply_to_id = ?", user.id)
  end
  def self.forShowingAtUserHome(user)
    where("user_id = :user_id OR in_reply_to_id = :user_id",
      user_id: user.id)
  end

  def ParseForLoginAndFindUser(string)
    temp = string.match(/\A@\w{3,10}/i)
    login = temp[0].match(/\w+/) if temp != nil
    reply_to = User.find_by_login(login[0]) if login != nil 
  end

  def RemoveLoginFromString()
      str = self.content.match(/\A@\w{3,10}/i)
      self.content = self.content[str[0].length..-1] if str
  end

private

  def is_reply?
    reply_to = self.ParseForLoginAndFindUser(self.content)
    if reply_to != nil
      self.RemoveLoginFromString
      self.in_reply_to_id = reply_to.id
    end 
  end

  
end
