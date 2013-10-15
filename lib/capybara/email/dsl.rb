module Capybara::Email::DSL

  def emails
    Capybara.using_driver(:email){
      Capybara.current_session.driver.emails
    }
  end

  def open_email email
    if Capybara.current_driver != :email
      @web_capybara_driver       = Capybara.current_driver
      @web_capybara_session_name = Capybara.session_name
      web_session = Capybara.current_session
      Capybara.current_driver = :email
      Capybara.current_session.driver.web_session = web_session
    end
    Capybara.current_session.driver.current_email = email
  end

  def close_email!
    if Capybara.current_driver == :email
      Capybara.current_driver = @web_capybara_driver
      Capybara.session_name   = @web_capybara_session_name
    end
  end

  # def visit url
  #   close_inbox!
  #   super
  # end

  # def emails

  # end




  # # Returns the currently set email.
  # # If no email set will return nil.
  # #
  # # @return [Mail::Message, nil]
  # attr_accessor :current_email
  # attr_accessor :current_emails

  # # Access all emails
  # #
  # # @return [Array]
  # def all_emails
  #   Mail::TestMailer.deliveries.map do |email|
  #     driver = Capybara::Email::Driver.new(email)
  #     Capybara::Node::Email.new(Capybara.current_session, driver)
  #   end
  # end

  # # Access all emails for a recipient.
  # #
  # # @param [String]
  # #
  # # @return [Array<Mail::Message>]
  # def emails_sent_to(recipient)
  #   self.current_emails = all_emails.select { |email| [email.to, email.cc, email.bcc].flatten.compact.include?(recipient) }.map do |email|
  #     driver = Capybara::Email::Driver.new(email)
  #     Capybara::Node::Email.new(Capybara.current_session, driver)
  #   end
  # end

  # # Access the first email for a recipient and set it to.
  # #
  # # @param [String]
  # #
  # # @return [Mail::Message]
  # def first_email_sent_to(recipient)
  #   self.current_email = emails_sent_to(recipient).last
  # end

  # # Returns a collection of all current emails retrieved
  # #
  # # @return [Array<Mail::Message>]
  # def current_emails
  #   @current_emails || []
  # end

  # # Clear the email queue
  # def clear_emails
  #   all_emails.clear
  #   self.current_emails = nil
  #   self.current_email  = nil
  # end
  # alias :clear_email :clear_emails
end
