module Capybara::Email::DSL

  %w{emails current_email}.each do |method|
    define_method method do |*args, &block|
      page.send method, *args, &block
    end
  end

  # switch to the email driver but remember what driver and
  # session we're on now
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

  # switch back to whatever driver & session we were using before
  def close_email!
    if Capybara.current_driver == :email
      current_session = Capybara.current_session
      current_session.driver.current_email = nil
      Capybara.current_driver = @web_capybara_driver
      Capybara.session_name   = @web_capybara_session_name
      @web_capybara_driver = @web_capybara_session_name = nil
      current_session
    end
  end

end
