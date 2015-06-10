class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def send_welcome
  NotificationMailer.welcome(params[:id]).deliver
    redirect_to new_subscriber_path
  end  

  def index
    @subscribers = Subscriber.all
    respond_with(@subscribers)
  end

  def show
    @subscriber = Subscriber.find(params[:id])
    respond_with(@subscriber)
  end

  def new
    @subscriber = Subscriber.new
    respond_with(@subscriber)
  end

  def edit
   @subscriber = Subscriber.find(params[:id])
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
        redirect_to posts_path, notice: "You have successfully subscribed."
        
    else 
      render 'new'
    end 
    
  end

  def update
    @subscriber = Subscriber.find(params[:id])
    @subscriber.update(subscriber_params)
    respond_with(@subscriber)
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy
    respond_with(@subscriber)
  end

  private
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    def set_email
      @email = Subscriber.find(params[:email])
    end  

    def subscriber_params
      params.require(:subscriber).permit(:name, :email, :mobile)
    end
end
