require 'parslet'

module Vm
  class VmCodeParser < Parslet::Parser
    COMMENT_DELIMITER = "//".freeze
    ARITHMETIC_OPERATIONS = %w[add sub neg eq gt lt and or not]
    MEMORY_ACCESS_OPERATIONS = %w[push pop]
    MEMORY_SEGMENTS = %w[argument local static constant this that pointer temp]

    root :lines

    # UTIL

    rule(:line)                  { space? >> instruction.maybe >> space? >> comment.maybe >> newline }
    rule(:lines)                 { line.repeat }

    rule(:instruction)            { arithmetic_instruction | memory_access_instruction }

    rule(:comment)               { (str(COMMENT_DELIMITER) >> (newline.absent? >> any).repeat) }

    rule(:space)                 { match('[[:blank:]]').repeat(1) }
    rule(:space?)                { space.maybe }
    rule(:newline)               { str("\r").maybe >> str("\n") >> str("\r").maybe }

    rule(:integer) { match('[0-9]').repeat(1) }

    # ARITHMETIC INSTRUCTIONS

    rule(:arithmetic_instruction) { ARITHMETIC_OPERATIONS.map { |e| str(e).as(:operation) }.inject(:|).as(:arithmetic_instruction) }

    # MEMORY ACCESS INSTRUCTIONS

    rule(:memory_access_instruction) { (operation >> space >> segment >> space >> integer.as(:index)).as(:memory_access_instruction) }

    rule(:operation) { MEMORY_ACCESS_OPERATIONS.map { |e| str(e).as(:operation) }.inject(:|) }

    rule(:segment) { MEMORY_SEGMENTS.map { |e| str(e).as(:segment) }.inject(:|) }
  end
end
