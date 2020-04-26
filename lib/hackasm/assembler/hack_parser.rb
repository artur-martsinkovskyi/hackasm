# frozen_string_literal: true

require 'parslet'
require_relative './constants/jumps'
require_relative './constants/dests'

module Assembler
  class HackParser < Parslet::Parser
    COMMENT_DELIMITER = '//'
    ADDRESS_DELIMITER = '@'
    JUMP_DELIMITER = ';'
    DEST_DELIMITER = '='
    root :lines

    # UTIL

    rule(:line)                { space? >> expression.maybe >> space? >> comment.maybe >> newline }
    rule(:lines)               { line.repeat }

    rule(:expression)          { address_instruction | jump_label | command_instruction }

    rule(:comment)             { (str(COMMENT_DELIMITER) >> (newline.absent? >> any).repeat) }

    rule(:space)               { match('[[:blank:]]').repeat(1) }
    rule(:space?)              { space.maybe }
    rule(:newline)             { str("\r").maybe >> str("\n") >> str("\r").maybe }

    # A-INSTRUCTIONS

    rule(:at)                  { match(ADDRESS_DELIMITER) }
    rule(:memory_address)      { (match('0') | (match('[1-9]') >> match('[0-9]').repeat)).as(:memory_address) }
    rule(:identifier)          { (match('[a-zA-Z_\-.$:]') >> match('[a-zA-Z_\-.$:0-9]').repeat(1)).as(:identifier) }

    rule(:address_instruction) { (at >> (memory_address | identifier)).as(:address_instruction) }

    # JUMP LABELS

    rule(:jump_label)          { (str('(') >> identifier >> str(')')).as(:jump_label) }

    # C-INSTRUCTIONS

    rule(:dest)                { DESTS.map { |s| str(s).as(:dest) >> space? >> str(DEST_DELIMITER) }.inject(:|) }

    rule(:comp_unary)          { match('[-!]').maybe >> match('[ADM]') }
    rule(:comp_binary)         { match('[ADM]') >> space? >> match('[+&|-]') >> space? >> match('[1ADM]') }
    rule(:comp)                { (str('0') | str('1') | str('-1') | comp_binary | comp_unary).as(:comp) }

    rule(:jump)                { JUMPS.map { |s| str(s) }.inject(:|).as(:jump) }

    rule(:command_instruction) do
      (
        dest.maybe >> space? >> comp >> space? >> (str(JUMP_DELIMITER) >> space? >> jump).maybe
      ).as(:command_instruction)
    end
  end
end
