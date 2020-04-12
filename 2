module Vm
  module Instructions
    module ArithmeticOperations
      class UnaryOperation
        OPERATION_TO_INSTRUCTION = {
          "neg" => "M=-M",
          "not" => "M=!M"
        }.freeze

        attr_reader :operation

        def initialize(operation)
          @operation = operation
        end

        def to_asm
          %Q{
          @SP
          M=M-1
          @SP
          A=M
          #{OPERATION_TO_INSTRUCTION[operation]}
          @SP
          M=M+1
          }.strip
        end

        def self.operations
          OPERATION_TO_INSTRUCTION.keys
        end
      end
    end
  end
end
