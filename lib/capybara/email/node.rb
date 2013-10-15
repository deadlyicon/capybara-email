# this is an html node in an email
class Capybara::Email::Node < Capybara::Driver::Node

  def initialize(driver, native)
    @driver = driver
    @native = native
  end

  def visible?
    true
  end

  def open
    driver.current_email = self
  end

  def html
    @html ||= html_content || convert_to_html(text)
  end

  def dom
    @dom ||= Nokogiri::HTML(html)
  end

  def text
    dom.text
  end
  alias_method :visible_text, :text
  alias_method :all_text, :text


  private

  def text_content
    return native.text_part.try(:body).to_s if native.multipart?
    return native.body.to_s if native.mime_type == 'text/plain'
  end

  def html_content
    return native.html_part.try(:body).try(:to_s) if native.multipart?
    return native.body.to_s if content_type.mime_type == 'text/html'
  end

  # def text
  #   native.text
  # end

  # def [](name)
  #   string_node[name]
  # end

  # def value
  #   string_node.value
  # end

  # def visible_text
  #   Capybara::Helpers.normalize_whitespace(unnormalized_text)
  # end

  # def all_text
  #   Capybara::Helpers.normalize_whitespace(text)
  # end

  # def click
  #   driver.follow(self[:href].to_s)
  # end

  # def tag_name
  #   native.node_name
  # end

  # def visible?
  #   string_node.visible?
  # end

  # def find(locator)
  #   native.xpath(locator).map { |node| self.class.new(driver, node) }
  # end

  # protected

  # def unnormalized_text
  #   if !visible?
  #     ''
  #   elsif native.text?
  #     native.text
  #   elsif native.element?
  #     native.children.map do |child|
  #       Capybara::Email::Node.new(driver, child).unnormalized_text
  #     end.join
  #   else
  #     ''
  #   end
  # end

  # private

  # def string_node
  #   @string_node ||= Capybara::Node::Simple.new(native)
  # end

  def convert_to_html(text)
    "<html><body>#{convert_links(text)}</body></html>"
  end

  def convert_links(text)
    text.gsub(%r{(https?://\S+)}, %q{<a href="\1">\1</a>})
  end
end
