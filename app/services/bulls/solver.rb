class Bulls::Solver

  attr_accessor :potentials

  def initialize(game)
    @game = game
    @potentials = []
    for i in 1234..9876
      @potentials << i if i.digits.uniq.length == i.digits.length
    end
    reduce_potentials
  end

  def next_move
    return @potentials.sample if @game.moves.size < 1
    @reduction = []
    @potentials.sample
  end

  private

  def reduce_potentials
    @game.moves.each do |move|
      new_potentials = []
      @potentials.each do |potential|
        new_potentials << potential unless should_del?(move, potential)
      end
      @potentials = new_potentials
    end
  end

  def should_del?(move, potential)
    number = move.number
    cows = move.result % 10
    bulls = move.result / 10
    result = false
    if number == potential && bulls != 4
      result = true
    elsif cows == 0 && bulls == 0
      result = true if (potential.digits & number.digits).size > 0
    else
      if (potential.digits & number.digits).size < bulls + cows
        result = true
      end
      if bulls > 0
        spheric_bulls = 0
        4.times do |i|
          spheric_bulls += 1 if potential.digits[i] == number.digits[i]
        end
        result = true if spheric_bulls < bulls
      end
    end
    result
  end
end



