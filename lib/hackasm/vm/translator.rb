# frozen_string_literal: true

require_relative './vm_code_parser'
require_relative './instructions/arithmetic_instruction'
require_relative './instructions/memory_access_instruction'

module Vm
  class Translator
    def initialize(text, object_name)
      @text = text
      @object_name = object_name
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
      when :arithmetic_instruction
        Instructions::ArithmeticInstruction.new(instruction_body).to_asm
      when :memory_access_instruction
        Instructions::MemoryAccessInstruction.new(instruction_body, @object_name).to_asm
      when :jump_label
        nil
      else raise 'Unknown instruction!'
      end
    end

    def parser
      @parser ||= VmCodeParser.new
    end

    def expressions
      @expressions ||= parser.parse(@text)
    end
  end
end
