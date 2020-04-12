module Assembler
  class SymbolTable
    DEFAULT_SYMBOL_TABLE = {
      "SP" => 0,
      "LCL" => 1,
      "ARG" => 2,
      "THIS" => 3,
      "THAT" => 4,
      "SCREEN" => 16384,
      "KBD" => 24576,
    }.merge(("0".."15").map { |i| ["R" + i, i.to_i] }.to_h).freeze

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
                           symbol = symbol && symbol.to_s
                           if symbol
                             symbol_table[symbol] = index - label_count
                             label_count += 1
                           end
                         end
                       end
    end

    def variable_symbols
      memory_location = 16
      @expressions.each.with_index.with_object({}) do |(expression, index), symbol_table|
        symbol = expression.dig(:address_instruction, :identifier)
        symbol = symbol && symbol.to_s
        if symbol && symbol_table[symbol].nil? && DEFAULT_SYMBOL_TABLE[symbol].nil? && label_symbols[symbol].nil?
          symbol_table[symbol] = memory_location
          memory_location += 1
        end
      end
    end
  end
end
