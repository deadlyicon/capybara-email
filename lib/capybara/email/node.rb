# this is an html node in an email
class Capybara::Email::Node < Capybara::RackTest::Node

  def click
    if tag_name == 'a'
      driver.visit(self[:href].to_s)
    else
      raise NotSupportedByDriverError, "cannot click #{tag_name} tags"
    end
  end

  def set(value)
    raise NotSupportedByDriverError, "#{self.class}#set"
  end

  def select_option
    raise NotSupportedByDriverError, "#{self.class}#select_option"
  end

  def unselect_option
    raise NotSupportedByDriverError, "#{self.class}#unselect_option"
  end

end
