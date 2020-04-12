require 'securerandom'

module Vm
  module Instructions
    module ArithmeticOperations
      class Comparison
        attr_reader :operation

        def initialize(operation)
          @operation = operation
        end

        def to_asm
          if_label = 'c_if_' + SecureRandom.hex(10)
          else_label = 'c_else_' + SecureRandom.hex(10)
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
            D=M-D
            @#{if_label}
            D;J#{operation.upcase}
            D=0
            @#{else_label}
            0;JEQ
            (#{if_label})
            D=-1
            (#{else_label})
            @SP
            A=M
            M=D
            @SP
            M=M+1
          }.strip
        end

        def self.operations
          %w[gt lt eq]
        end
      end
    end
  end
end

