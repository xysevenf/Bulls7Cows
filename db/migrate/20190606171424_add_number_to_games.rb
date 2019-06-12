class AddNumberToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :number, :integer
  end
end
