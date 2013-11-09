class Micropost < ActiveRecord::Base

  default_scope order: 'microposts.created_at DESC'
   #you were talking about smth like that? is it realy better then class method?
  scope :for_showing_at_user_home, lambda{ |user |where("user_id = :user_id OR in_reply_to_id = :user_id",
       user_id: user.id)}


  attr_accessible :content, :in_reply_to_id


  belongs_to    :user
  before_save   :check_for_login_and_remove_it


  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }


  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR in_reply_to_id = :user_id",
          user_id: user.id)
  end

  def self.from_users_replied_to(user)
    where("in_reply_to_id = ?", user.id)
  end

  def parse_for_login_and_find_user(string)
    login = content.match(/\A@(\w{3,10})/i).try(:[], 1)
    User.find_by_login(login) 
  end

  def remove_login_from_string()
      str = self.content.match(/\A@\w{3,10}/i)
      self.content = self.content[str[0].length..-1] if str
  end

private

  def check_for_login_and_remove_it
    reply_to = self.parse_for_login_and_find_user(self.content)
    if reply_to != nil
      self.remove_login_from_string
      self.in_reply_to_id = reply_to.id
    end 
  end

  
end
