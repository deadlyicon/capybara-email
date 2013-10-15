class Capybara::Email::Driver < Capybara::Driver::Base

  def initialize(app)
    # we dont need the app
  end

  attr_accessor :web_session

  def visit(path)
    web_session.driver.visit path
  end

  def find_xpath(query)
    find(:xpath, query)
  end

  def find_css(query)
    find(:css, query)
  end

  def html
    current_email ? current_email.html : ''
  end

  attr_accessor :current_email

  def emails
    Mail::TestMailer.deliveries.map do |email|
      Capybara::Node::Email.new(Capybara.current_session, email)
    end
  end

  def find_xpath(query)
    current_email.find_xpath query
  end

  def find_css(query)
    current_email.find_css query
  end



  def current_url
    raise Capybara::NotSupportedByDriverError, "#{self.class}#current_url"
  end

  def execute_script(script)
    raise Capybara::NotSupportedByDriverError, "#{self.class}#execute_script"
  end

  def evaluate_script(script)
    raise Capybara::NotSupportedByDriverError, "#{self.class}#evaluate_script"
  end

  def save_screenshot(path, options={})
    raise Capybara::NotSupportedByDriverError, "#{self.class}#save_screenshot"
  end

  def response_headers
    raise Capybara::NotSupportedByDriverError, "#{self.class}#response_headers"
  end

  def status_code
    raise Capybara::NotSupportedByDriverError, "#{self.class}#status_code"
  end

  def within_frame(frame_handle)
    raise Capybara::NotSupportedByDriverError, "#{self.class}#within_frame"
  end

  def within_window(handle)
    raise Capybara::NotSupportedByDriverError, "#{self.class}#within_window"
  end

end

