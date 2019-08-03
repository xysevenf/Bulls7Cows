class Bulls::Solver

  attr_reader :potentials

  def initialize(moves = [])
    @moves = moves
    @potentials = []
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

  def should_del?(move, potential)
    number = move.number
    number_digits = number.digits
    number_digits << 0 if number_digits.size < 4
    potential_digits = potential.digits
    potential_digits << 0 if potential_digits.size < 4
    cows = move.cows
    bulls = move.bulls
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
end



