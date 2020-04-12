module Vm
  module Instructions
    module ArithmeticOperations
      class BinaryOperation
        OPERATION_TO_INSTRUCTION = {
          "add" => "M=M+D",
          "sub" => "M=M-D",
          "and" => "M=M&D",
          "or" => "M=M|D",
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
            D=M
            @SP
            M=M-1
            @SP
            A=M
            #{instruction}
            @SP
            M=M+1
          }.strip
        end

        def self.operations
          OPERATION_TO_INSTRUCTION.keys
        end

        private

        def instruction
          OPERATION_TO_INSTRUCTION[operation]
        end
      end
    end
  end
end
