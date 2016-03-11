# b0b.rb
# translated from B0B.F

module The_b0b
  # random boolean true or false
  def brnd; rand(0) < 0.5; end

  # return 0 or 1
  def rand1; rand(2); end
  # return 0, 1 or 2
  def rand2; rand(3); end
  # etc.
  def rand3; rand(4); end
  def rand4; rand(5); end
  def rand5; rand(6); end
  def randN(n); rand(n.to_i + 1); end
end
