module MovingInLine

  def horizontal_check(piece, board, position, offset)
    return check_left?(piece, board, position) if offset.negative?
    return check_right?(piece, board, position) if offset.positive?

    false
  end

  def vertical_check(piece, board, position, offset)
    return check_down?(piece, board, position) if offset.positive?
    return check_up?(piece, board, position) if offset.negative?

    false
  end

  ##
  # @param [Piece] piece
  # @param [Array] position
  # @param [Board] board
  def check_lines?(piece, position, board)
    movement = [] << position[0] - piece.position[0] << position[1] - piece.position[1]
    return false unless (movement[0]).zero? || (movement[1]).zero?
    return horizontal_check(piece, board, position, movement[1]) if (movement[0]).zero?
    return vertical_check(piece, board, position, movement[0]) if (movement[1]).zero?

    false
  end

  private

  ##
  # @param [Array] position
  # @param [Array] other
  def get_position(position, other)
    [] << position[0] + other[0] << position[1] + other[1]
  end

  ##
  # @param [Array] current
  # @param [Board] board
  # @yieldparam next_matcher a checking method defined below
  def check_next(current, board)
    board.at(current).empty? ? yield : false
  end

  def check_left?(piece, board, max_position, current = [0, -1])
    position = get_position(piece.position, current)
    return true if position == max_position

    check_next(position, board) { check_left?(piece, board, max_position, get_position(current, [0, -1])) }
  end

  def check_right?(piece, board, max_position, current = [0, 1])
    position = get_position(piece.position, current)
    return true if position == max_position

    check_next(position, board) { check_right?(piece, board, max_position, get_position(current, [0, 1])) }
  end

  def check_down?(piece, board, max_position, current = [1, 0])
    position = get_position(piece.position, current)
    return true if position == max_position

    check_next(position, board) { check_down?(piece, board, max_position, get_position(current, [1, 0])) }
  end

  def check_up?(piece, board, max_position, current = [-1, 0])
    position = get_position(piece.position, current)
    return true if position == max_position

    check_next(position, board) { check_up?(piece, board, max_position, get_position(current, [-1, 0])) }
  end
end
