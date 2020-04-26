# frozen_string_literal: true

require 'pry'
require_relative './hack_parser'
require_relative './symbol_table'
require_relative './instructions/address_instruction'
require_relative './instructions/command_instruction'

module Assembler
  class Translator
    def initialize(text)
      @text = text
    end

    def translate
      expressions = parser.parse(@text)
      expressions.map do |expression|
        process_instruction(expression)
      end.compact.join("\n") << "\n"
    rescue Parslet::ParseFailed => e
      e.parse_failure_cause.ascii_tree
    end

    private

    def process_instruction(instruction)
      instruction_name = instruction.keys.first
      instruction_body = instruction.values.first

      case instruction_name
      when :address_instruction
        Instructions::AddressInstruction.new(instruction_body, symbol_table).to_b
      when :command_instruction
        Instructions::CommandInstruction.new(instruction_body).to_b
      when :jump_label
        nil
      else raise 'Unknown instruction!'
      end
    end

    def parser
      @parser ||= HackParser.new
    end

    def expressions
      @expressions ||= parser.parse(@text)
    end

    def symbol_table
      @symbol_table ||= SymbolTable.new(expressions).to_h
    end
  end
end
