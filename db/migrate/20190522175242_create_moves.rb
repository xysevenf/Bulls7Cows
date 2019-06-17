class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.integer :number
      t.integer :result
      t.references :game, foreign_key: true
      t.timestamps
    end
  end
end
