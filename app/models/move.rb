class Move < ApplicationRecord

  belongs_to :game

  validates :number, presence: true, numericality: { only_integer: true,
                                                     greater_than_or_equal_to: 123,
                                                     less_than_or_equal_to: 9876
                                                   }
  validates :bulls, presence: true, numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 0,
                                                    less_than_or_equal_to: 4
                                                  }
  validates :cows, presence: true, numericality: { only_integer: true,
                                                   greater_than_or_equal_to: 0,
                                                   less_than_or_equal_to: 4
                                                 }
  validates_with MoveValidator

end
