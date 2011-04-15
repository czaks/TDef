module TDef
  module Error
    # Base exception
    # @abstract
    class GameException < RuntimeError
    end
    
    # Not enough cash when tried to buy or upgrade a tower
    class InsufficientCash < GameException
    end
    
    # Tried to put a tower on another tower, monster, or tried to
    # lock monsters' way.
    class IncorrectPlacement < GameException
    end
    
    # The game has now been ended.
    class EndGame < GameException
    end
  end
end