# Checks that there is a space after comma
PuppetLint.new_check(:space_after_comma) do
  def check
    tokens.select { |r| r.type == :COMMA }.each do |token|
      if token.next_token && !whitespace?(token.next_token.type)
        next if last_comma_in_list?(token)
        notify :warning,
               message: "Add space after the comma",
               line: token.line,
               column: token.column,
               token: token
      end
    end
  end

  def fix(problem)
    index = tokens.index(problem[:token])
    tokens.insert(index + 1, PuppetLint::Lexer::Token.new(:WHITESPACE, ' ', 0, 0))
  end

  def whitespace?(type)
    [:WHITESPACE, :NEWLINE].include?(type)
  end

  def last_comma_in_list?(token)
    [:RBRACK, :RBRACE, :RPAREN].include?(token.next_token.type)
  end
end
