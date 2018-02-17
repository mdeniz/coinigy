class Array
  def find_by(method, value)
    find { |x| x.send(method) == value }
  end
end
