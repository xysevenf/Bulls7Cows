class Bulls::Game

  attr_accessor :moves, :secret

  def initialize
    @secret = gen_secret
    @moves = []
  end

  def gen_secret
    @secret = 0
    (0..9).to_a.shuffle[0..3].each_with_index do |el, i|
      @secret += el * 10**i
    end
    @secret
  end

  def guess(num)
    bulls = 0
    cows = 0
    for n in 1..4 do
      n_digit = (num - (num / 10**n) * 10**n) / 10**(n - 1)
      for s in 1..4 do
        s_digit = (@secret - (@secret / 10**s) * 10**s) / 10**(s - 1)
        cows += 1 if n_digit == s_digit && n != s
        bulls += 1 if n_digit == s_digit && n == s
      end
    end
    bulls * 10 + cows
  end

end
