require "test/version"


def compute(op, a, b)
  case op
    when '+'
      a + b
    when '-'
      a - b
    when '*'
      a * b
    when '/'
      a / b
    else
      raise ArgumentError.new("undefined op #{op}")
  end
end

def is_operand?(s)
  s =~ /^[-+]?[0-9]+$/
end

def is_operator?(s)
  ops = ['+', '-', '*', '/']
  ops.include?(s)
end

def evaluate(tokens)
  line = tokens.join(' ')
  operands = []
  tokens.each do |token|
    if is_operand?(token)
      operands << token.to_i
    elsif is_operator?(token)
      if operands.length < 2
        raise "bad expression '#{line}'"
      end
      operands << compute(token, operands.pop, operands.pop)
    else
      raise "bad token '#{token}'"
    end
  end
  if operands.length != 1
    raise "bad expression '#{line}'"
  end
  operands[0]
end

def parse
  line = gets.chomp
  case line
    when 'q'
      exit
  end
  tokens = line.split
end

def main
  tokens = parse
  puts evaluate(tokens)
end

main