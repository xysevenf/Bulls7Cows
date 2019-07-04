class Bulls::Solver

  attr_reader :potentials, :estimates

  def initialize(moves = [])
    @moves = moves
    @potentials = []
    @estimates = []
    for i in 123..9876
      if i.to_s.size == 3 && i.digits.any?{ |d| d == 0 }
        next
      elsif i.digits.uniq.length == i.digits.length
        @potentials << i
      end
    end
    reduce_potentials
  end

  def next_move
    return @potentials.sample if @moves.size < 1
    # if @potentials.size < 150
    #   @estimates = estimate_moves(@potentials)
    # end
    @potentials.sample
  end

  def reduce_potentials_last
    new_potentials = []
      @potentials.each do |potential|
        new_potentials << potential unless should_del?(@moves.last, potential)
      end
    @potentials = new_potentials
  end

  private

  def reduce_potentials
    @moves.each do |move|
      new_potentials = []
      @potentials.each do |potential|
        new_potentials << potential unless should_del?(move, potential)
      end
      @potentials = new_potentials
    end
  end

  def count_reduce_potentials(move)
    counter = 0
    @potentials.each do |potential|
      counter += 1 if should_del?(move, potential)
    end
    counter
  end

  def should_del?(move, potential)
    number = move.number
    number_digits = number.digits
    number_digits << 0 if number_digits.size < 4
    potential_digits = potential.digits
    potential_digits << 0 if potential_digits.size < 4
    cows = move.result % 10
    bulls = move.result / 10
    result = false
    if number == potential && bulls != 4
      result = true
    elsif cows == 0 && bulls == 0
      result = true if (potential_digits & number_digits).size > 0
    else
      if (potential_digits & number_digits).size != bulls + cows
        result = true
      end
      if bulls > 0
        spheric_bulls = 0
        4.times do |i|
          spheric_bulls += 1 if potential_digits[i] == number_digits[i]
        end
        result = true if spheric_bulls != bulls
      else
        4.times do |i|
          if number.digits[i] == potential.digits[i]
            result = true
            break
          end
        end
      end
    end
    result
  end

  def estimate_moves(potentials)
    result = []
    game = Bulls::Game.new_no_secret
    move = Struct.new(:number, :result).new
    potentials.each do |potential|
      reduction_estimates = []
      potentials.each do |target|
        next if target == potential
        move.number = potential
        move.result = game.bulls_cows(potential, target)
        reduction_estimates << count_reduce_potentials(move)
      end
      result << reduction_estimates.inject { |sum, el| sum + el }
    end
  result.sort
  end
end



