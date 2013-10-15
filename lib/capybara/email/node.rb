# this is an html node in an email
class Capybara::Email::Node < Capybara::RackTest::Node

  def click
    if tag_name == 'a'
      driver.visit(self[:href].to_s)
    # elsif (tag_name == 'input' and %w(submit image).include?(type)) or
    #     ((tag_name == 'button') and type.nil? or type == "submit")
    #   Capybara::RackTest::Form.new(driver, form).submit(self)
    end
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


end
