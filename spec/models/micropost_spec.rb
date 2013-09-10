require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create( :user ) }
  let(:direct_micropost) {user.microposts.build(content: "@sweider_b alksdjfalkdj")}
  
  before do
    @micropost = user.microposts.build(content: "@sweider_b Lorem")
  end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }  
  it { should respond_to(:user) }
  it { should respond_to(:in_reply_to_id) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id missed" do
    before { @micropost.user_id = nil }

    it { should_not be_valid }
  end

  describe "should fill in " do
    before { @micropost.save }
      
    its(:in_reply_to_id) { should == 1 }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
