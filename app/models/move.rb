class Move < ApplicationRecord
  belongs_to :game

  validates :number, presence: true
  validates :result, presence: true

  scope :with_result, -> { where.not(result: nil) }

end
