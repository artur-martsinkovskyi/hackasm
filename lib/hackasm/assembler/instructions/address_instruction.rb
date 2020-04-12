module Assembler
  module Instructions
    class AddressInstruction
      def initialize(instruction, symbol_table)
        @instruction = instruction.compact.map { |key, value| [key, value.to_s] }.to_h
        @symbol_table = symbol_table
      end

      def to_b
        if memory_address = @instruction[:memory_address]
          memory_address.to_i
        elsif identifier = @instruction[:identifier]
          @symbol_table[identifier]
        end.to_s(2).rjust(16, '0')
      end
    end
  end
end
