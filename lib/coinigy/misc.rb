class Array
  def find_by(method, value)
    find { |x| x.send(method) == value }
  end
end

class Module
  def alias_attribute(new_attr, original)
    alias_method(new_attr, original) if method_defined? original
    new_writer = "#{new_attr}="
    original_writer = "#{original}="
    alias_method(new_writer, original_writer) if method_defined? original_writer
  end
end
