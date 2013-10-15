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
      Capybara::Node::Email.new(Capybara.current_session, self)
    end
  end

  def find_xpath(query)
    current_email.find(:xpath, query)
  end

  def find_css(query)
    current_email.find(:css, query)
  end


  # def find_xpath(query)
  #   find(:xpath, query)
  # end

  # def find_css(query)
  #   find(:css, query)
  # end

  # def find(format, selector)
  #   if format==:css
  #     dom.css(selector, Capybara::RackTest::CSSHandlers.new)
  #   else
  #     dom.xpath(selector)
  #   end.map { |node| Capybara::Email::Node.new(self, node) }
  # end

  # # current_email should act like a Mail::Message
  # delegate :subject, :to, :from, :reply_to, to: :current_email

  # def text
  #   dom.text
  # end

  # def html
  #   @html ||= html_content || convert_to_html(text)
  # end

  # def dom
  #   @dom ||= Nokogiri::HTML(html)
  # end

  # def body
  #   html
  # end

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


  # private

  # def text_content
  #   return current_email.text_part.try(:body).to_s if current_email.multipart?
  #   return current_email.body.to_s if current_email.mime_type == 'text/plain'
  # end

  # def html_content
  #   binding.pry
  #   return current_email.html_part.try(:body).try(:to_s) if current_email.multipart?
  #   return current_email.body.to_s if content_type.mime_type == 'text/html'
  # end

  # def convert_to_html(text)
  #   "<html><body>#{convert_links(text)}</body></html>"
  # end

  # def convert_links(text)
  #   text.gsub(%r{(https?://\S+)}, %q{<a href="\1">\1</a>})
  # end


end

