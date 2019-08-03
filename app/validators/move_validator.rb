class MoveValidator < ActiveModel::Validator
  def validate(record)
    number_digits = record.number.digits
    number_digits.unshift 0 if number_digits.size < 4
    if number_digits.uniq.size < number_digits.size
      record.errors[:number] << 'Цифры в числе не должны повторяться!'
    end
  end
end