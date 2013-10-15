# this is a node that wraps an email
class Capybara::Node::Email < Capybara::Node::Document

  # @session @base

  def open
    session.driver.current_email = self
  end

  def text_content
    return base.text_part.try(:body).to_s if base.multipart?
    return base.body.to_s if base.mime_type == 'text/plain'
  end

  def html_content
    return base.html_part.try(:body).try(:to_s) if base.multipart?
    return base.body.to_s if content_type.mime_type == 'text/html'
  end

  def convert_to_html(text)
    "<html><body>#{convert_links(text)}</body></html>"
  end

  def convert_links(text)
    text.gsub(%r{(https?://\S+)}, %q{<a href="\1">\1</a>})
  end


  def html
    @html ||= html_content || convert_to_html(text)
  end

  def dom
    @dom ||= Nokogiri::HTML(html)
  end

  # base is a driver

  def email
    @base
  end

  # Delegate to the email body
  #
  # @return [Mail::Message#body]
  def body
    base.raw
  end

  # Delegate to the email subject
  #
  # @return [Mail::Message#subject]
  def subject
    base.subject
  end

  # Delegate to the email to
  #
  # @return [Mail::Message#to]
  def to
    base.to
  end

  # Delegate to the email reply_to
  #
  # @return [Mail::Message#reply_to]
  def reply_to
    base.email.reply_to
  end

  # Delegate to the email from
  #
  # @return [Mail::Message#from]
  def from
    base.from
  end

  # Save a snapshot of the page.
  #
  # @param  [String] path     The path to where it should be saved [optional]
  #
  def save_page(path = nil)
    path ||= "capybara-email-#{Time.new.strftime("%Y%m%d%H%M%S")}#{rand(10**10)}.html"
    path = File.expand_path(path, Capybara.save_and_open_page_path) if Capybara.save_and_open_page_path

    FileUtils.mkdir_p(File.dirname(path))

    File.open(path,'w') { |f| f.write(body) }
    path
  end

  # Save a snapshot of the page and open it in a browser for inspection
  #
  # @param  [String] path     The path to where it should be saved [optional]
  #
  def save_and_open(file_name = nil)
    require 'launchy'
    Launchy.open(save_page(file_name))
  rescue LoadError
    warn 'Please install the launchy gem to open page with save_and_open_page'
  end
end
