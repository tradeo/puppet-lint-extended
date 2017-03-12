# Public: Test the manifest tokens for variables that contain a dash and
# record a warning for each instance found.
#
# No style guide reference
PuppetLint.new_check(:space_around_operators) do
  OPERATORS = %i(EQUALS ISEQUAL NOTEQUAL MATCH APPENDS PLUS GREATEREQUAL
                 LESSEQUAL GREATERTHAN LESSTHAN NOMATCH).freeze

  def check
    tokens.select { |r| OPERATORS.include? r.type }.each do |token|
      missing_space_on_left(token) do
        display_error(token, "Surrounding space missing for operator #{token.value}")
        return
      end

      missing_space_on_right(token) do
        display_error(token, "Surrounding space missing for operator #{token.value}")
        return
      end
    end
  end

  def fix(problem)
    missing_space_on_left(problem[:token]) do
      index = tokens.index(problem[:token])
      tokens.insert(index, PuppetLint::Lexer::Token.new(:WHITESPACE, ' ', 0, 0))
    end

    missing_space_on_right(problem[:token]) do
      index = tokens.index(problem[:token])
      tokens.insert(index + 1, PuppetLint::Lexer::Token.new(:WHITESPACE, ' ', 0, 0))
    end
  end

  def missing_space_on_left(token)
    yield if token.prev_token.type != :WHITESPACE
  end

  def missing_space_on_right(token)
    yield unless [:WHITESPACE, :NEWLINE].include?(token.next_token.type)
  end

  def display_error(token, message)
    notify :warning,
           message: message,
           line: token.line,
           column: token.column,
           token: token
  end
end
