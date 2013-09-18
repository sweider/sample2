class MessagesController < ApplicationController
  before_filter :autorizate!


  def create
   current_user.messages.create!(params[:message])


    respond_to do |format|
      format.html { redirect_to @user}
      format.js 
    end
  end

  def ajax_getting
    @message = Message.find(params[:id])
    @sender = User.find(@message.user_id)
    @reciever = User.find(@message.to)
  end
  
end