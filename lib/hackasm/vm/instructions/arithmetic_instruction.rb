require_relative './arithmetic_operations/comparison'
require_relative './arithmetic_operations/binary_operation'
require_relative './arithmetic_operations/unary_operation'

module Vm
  module Instructions
    class ArithmeticInstruction
      attr_reader :operation

      def initialize(instruction)
        @operation = instruction[:operation].to_s
      end

      def to_asm
        comment + case operation
        when *ArithmeticOperations::Comparison.operations
          ArithmeticOperations::Comparison.new(operation).to_asm
        when *ArithmeticOperations::UnaryOperation.operations
          ArithmeticOperations::UnaryOperation.new(operation).to_asm
        when *ArithmeticOperations::BinaryOperation.operations
          ArithmeticOperations::BinaryOperation.new(operation).to_asm
        end.split("\n").map(&:strip).join("\n")
      end

      def comment
        "// #{operation}\n"
      end
    end
  end
end
