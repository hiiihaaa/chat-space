class MessagesController < ApplicationController
  def index
  end
  
  def create
    @message=@group.messages.new(message_params)
  end

end

