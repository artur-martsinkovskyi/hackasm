# frozen_string_literal: true

module Assembler
  class SymbolTable
    DEFAULT_SYMBOL_TABLE = {
      'SP' => 0,
      'LCL' => 1,
      'ARG' => 2,
      'THIS' => 3,
      'THAT' => 4,
      'SCREEN' => 16_384,
      'KBD' => 24_576
    }.merge(('0'..'15').map { |i| ['R' + i, i.to_i] }.to_h).freeze
    VARIABLE_SEGMENT_START = 16

    def initialize(expressions)
      @expressions = expressions
    end

    def to_h
      DEFAULT_SYMBOL_TABLE.merge(
        label_symbols
      ).merge(
        variable_symbols
      )
    end

    private

    def label_symbols
      @label_symbols ||= begin
                           label_count = 0
                           @expressions.each.with_index.with_object({}) do |(expression, index), symbol_table|
                             symbol = expression.dig(:jump_label, :identifier)
                             next unless symbol

                             symbol_table[symbol.to_s] = index - label_count
                             label_count += 1
                           end
                         end
    end

    def variable_symbols
      current_variable_memory_location = VARIABLE_SEGMENT_START
      address_expressions.each_with_object({}) do |expression, symbol_table|
        symbol = expression.dig(:address_instruction, :identifier).to_s

        next if symbol_already_processed?(symbol, symbol_table)

        symbol_table[symbol] = current_variable_memory_location
        current_variable_memory_location += 1
      end
    end

    def symbol_already_processed?(symbol, symbol_table)
      symbol_table.key?(symbol) || DEFAULT_SYMBOL_TABLE.key?(symbol) || label_symbols.key?(symbol)
    end

    def address_expressions
      @address_expressions ||= @expressions.select { |expression| expression.dig(:address_instruction, :identifier) }
    end
  end
end
