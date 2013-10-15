# this is a node that wraps an email
class Capybara::Node::Email < Capybara::Node::Document

  # base should act like a Mail::Message
  delegate :subject, :to, :from, :reply_to, to: :base

  def open
    session.driver.current_email = self
  end

  def text
    dom.text
  end

  def html
    @html ||= html_content || convert_to_html(text)
  end

  def dom
    @dom ||= Nokogiri::HTML(html)
  end

  def body
    html
  end

  def find_xpath(query)
    find(:xpath, query)
  end

  def find_css(query)
    find(:css, query)
  end

  def find(format, selector)
    if format==:css
      dom.css(selector, Capybara::RackTest::CSSHandlers.new)
    else
      dom.xpath(selector)
    end.map { |node| Capybara::Email::Node.new(self, node) }
  end

  private

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

end
