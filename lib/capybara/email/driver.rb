class Capybara::Email::Driver < Capybara::Driver::Base

  def initialize(app)
    # we dont need the app
  end

  attr_accessor :current_email

  def emails
    Mail::TestMailer.deliveries.map do |email|
      Capybara::Email::Node.new(self, email)
    end
  end

  def dom
    current_email.dom
  end

  def find(format, selector)
    if format==:css
      dom.css(selector, Capybara::RackTest::CSSHandlers.new)
    else
      dom.xpath(selector)
    end.map { |node| Capybara::Email::Node.new(self, node) }
  end

  def find_xpath(query)
    find(:xpath, query)
  end

  def find_css(query)
    find(:css, query)
  end

  def current_url
    raise Capybara::NotSupportedByDriverError, "#{self.class}#current_url"
  end

  def visit(path)
    raise Capybara::NotSupportedByDriverError, "#{self.class}#visit"
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


  # def body
  #   dom.to_xml
  # end

  # # Access to email subject
  # #
  # #  delegates back to instance of Mail::Message
  # #
  # # @return String
  # def subject
  #   email.subject
  # end

  # # Access to email recipient(s)
  # #
  # #  delegates back to instance of Mail::Message
  # #
  # # @return [Array<String>]
  # def to
  #   email.to
  # end

  # # Access to email sender(s)
  # #
  # #  delegates back to instance of Mail::Message
  # #
  # # @return [Array<String>]
  # def from
  #   email.from
  # end

  # # Nokogiri object for traversing content
  # #
  # # @return Nokogiri::HTML::Document
  # def dom
  #   @dom ||= Nokogiri::HTML(source)
  # end

  # # Find elements based on given xpath
  # #
  # # @param [xpath string]
  # #
  # # @return [Array<Capybara::Driver::Node>]
  # def find(selector)
  #   dom.xpath(selector).map { |node| Capybara::Email::Node.new(self, node) }
  # end

  # alias_method :find_xpath, :find


  # # String version of email HTML source
  # #
  # # @return String
  # def source
  #   if email.mime_type == 'text/plain'
  #     convert_to_html(raw)
  #   else
  #     raw
  #   end
  # end

  # # Plain text email contents
  # #
  # # @return String
  # def raw
  #   if email.mime_type =~ /\Amultipart\/(alternative|related|mixed)\Z/
  #     if email.html_part
  #       return email.html_part.body.to_s
  #     elsif email.text_part
  #       return email.text_part.body.to_s
  #     end
  #   end

  #   return email.body.to_s
  # end

  # private

  # def convert_to_html(text)
  #   "<html><body>#{convert_links(text)}</body></html>"
  # end

  # def convert_links(text)
  #   text.gsub(%r{(https?://\S+)}, %q{<a href="\1">\1</a>})
  # end
end

