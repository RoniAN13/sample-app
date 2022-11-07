class ChatroomsController < ApplicationController
include SessionsHelper
before_action :logged_in_user
  def index
    @current_user = current_user
    @chatrooms = Chatroom.public_rooms
    @users = @current_user.following

  end
  def create
    @chatroom = Chatroom.create(name: params["chatroom"]["name"])
  end
  def show
    @current_user = current_user
    @single_room = Chatroom.find(params[:id])
    @chatrooms = Chatroom.public_rooms
    @users = User.all_except(@current_user)
    @chatroom = Chatroom.new
    @message = Message.new
    @messages = @single_room.messages
    render "index"
  end
end
