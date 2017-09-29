# Checks that operators have space around them
PuppetLint.new_check(:space_inside_braces) do

  def check
    tokens.select { |r| [:LBRACE, :RBRACE].include? r.type }.each do |token|
      missing_space_after_opening(token) do
        display_error(token, "Add space after opening brace")
      end

      missing_space_before_closing(token) do
        display_error(token, "Add space before closing brace")
      end
    end
  end

  def fix(problem)
    missing_space_after_opening(problem[:token]) do
      index = tokens.index(problem[:token])
      add_token(index + 1, PuppetLint::Lexer::Token.new(:WHITESPACE, ' ', 0, 0))
    end

    missing_space_before_closing(problem[:token]) do
      index = tokens.index(problem[:token])
      add_token(index, PuppetLint::Lexer::Token.new(:WHITESPACE, ' ', 0, 0))
    end
  end

  def missing_space_after_opening(token)
    return unless token.type == :LBRACE
    return if token.next_token.nil? || token.next_token.type == :RBRACE
    yield unless [:WHITESPACE, :NEWLINE, :INDENT].include?(token.next_token.type)
  end

  def missing_space_before_closing(token)
    return unless token.type == :RBRACE
    return if token.prev_token.nil? || token.prev_token.type == :LBRACE
    yield unless [:WHITESPACE, :NEWLINE, :INDENT].include?(token.prev_token.type)
  end

  def display_error(token, message)
    notify :warning,
           message: message,
           line: token.line,
           column: token.column,
           token: token
  end
end
