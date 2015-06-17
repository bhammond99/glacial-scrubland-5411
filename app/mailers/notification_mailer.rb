class NotificationMailer < ActionMailer::Base
  default from: "wildgenius99@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.welcome.subject
  #
  def welcome(subscriber)
    @subscriber = subscriber
    @url = 'http://localhost:3000/posts'
    mail to:  "#{@subscriber.name} <#{@subscriber.email}>",
          from:  "wildgenius99@gmail.com",
          subject: 'Welcome to My Blog'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.notify.subject
  #
  def notify(post_id)
    @greeting = "Hi"
    @post = Post.find(post_id)

    mail to: "bkushwauter@gmail.com",
          from: "wildgenius99@gmail.com",
            :subject => "Brand new post: #{@post.title}"
  end
end
