namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do    
    create_me    
    make_users
    make_posts
    make_relationships
  end

  def make_relationships
    users = User.all
    user  = users.first
    followed_users = users[2..50]
    followers      = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
  end

  def create_me
    admin = User.create!(name: "Alex",
                         email: "sweider.b@gmail.com",
                         login: "sweider_b",
                         password: "q1w2e3r4t5",
                         password_confirmation: "q1w2e3r4t5")
    admin.toggle!(:admin)
  end

  def make_users
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      login = "ex_login#{n+1}"
      User.create!(name: name,
                   email: email,
                   login: login,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_posts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end


end
