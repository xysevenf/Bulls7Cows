class AddCowAndBullToMove < ActiveRecord::Migration[5.2]
  def up
    add_column :moves, :bulls, :integer
    add_column :moves, :cows, :integer
    Move.all.find_each do |move|
      move.update(bulls: move.result / 10, cows: move.result % 10)
    end
    remove_column :moves, :result
  end

  def down
    add_column :moves, :result, :integer
    Move.all.find_each do |move|
      move.update(result: move.cows + move.bulls * 10)
    end
    remove_column :moves, :bulls, :integer
    remove_column :moves, :cows, :integer
  end
end
