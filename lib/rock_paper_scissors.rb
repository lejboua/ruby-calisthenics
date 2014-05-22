class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.correct_match?(match)
    return false if match == nil || !(match.is_a? Array) || match.count != 2
    (self.correct_strategy? match.first) && (self.correct_strategy? match.last)
  end

  def self.correct_strategy?(strategy)
    return false if strategy == nil || !(strategy.is_a? Array) || strategy.count != 2
    (['R','S','P'].index { |s| s == strategy.last }) != nil
  end

  def self.winner(player1, player2)
    if !self.correct_strategy?(player1) || !self.correct_strategy?(player2)
      raise NoSuchStrategyError.new 'Strategy must be one of R,P,S' 
    end
    return player1 if player1.last == player2.last
    p1 = player1.last
    p2 = player2.last
    if p1 == 'R'
      if p2 == 'S'
        return player1
      else
        return player2
      end
#return player1 if p2 == 'S' else return player2
    end
    if p1 == 'S'
      if p2 == 'P'
        return player1
      else
        return player2
      end
#return player1 if p2 == 'P' else return player2
    end
    if p1 == 'P'
      if p2 == 'R'
        return player1
      else
        return player2
      end
#return player1 if p2 == 'R' else return player2
    end
  end

  def self.tournament_winner(tournament)
    return self.winner(tournament.first, tournament.last) if self.correct_match? tournament
    return self.winner(self.tournament_winner(tournament.first), self.tournament_winner(tournament.last))
  end

end
