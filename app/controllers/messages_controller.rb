class MessagesController < ApplicationController
  before_filter :authorize_admin, only: [:show, :index, :destroy]

  def show
    @message = Message.where(id: params[:id]).first
  end

  def index
    @messages = Message.all.order(created_at: :desc)
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = "We have received your message, a representative will get back to you as soon as possible. Thank you for taking the time to reach out to us."
      SpartanMailer.new_message(@message).deliver
    else
      flash[:alert] = "Failed to send your message, please make sure that all the fields are filled out."
    end
    redirect_to :back
  end
  
  def toggle_answered
    @message = Message.find(params[:id])
    @message.was_answered = !@message.was_answered
    @message.save
    redirect_to @message
  end

  def destroy
    @message = Message.where(id: params[:id]).first
    @message.destroy
    flash[:notice] = "Message deleted!"
    redirect_to messages_path
  end

  protected

  def message_params
    params.require(:message).permit(:sender_email, :subject, :content)
  end
end
