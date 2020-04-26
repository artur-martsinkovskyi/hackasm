# frozen_string_literal: true

require 'securerandom'

module Vm
  module Instructions
    module ArithmeticOperations
      class Comparison
        attr_reader :operation
        IF_PREFIX = 'c_if_'
        ELSE_PREFIX = 'c_else_'
        OPERATION_TEMPLATE = %{
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
            @%<if_label>s
            D;J%<operation>s
            D=0
            @%<else_label>s
            0;JEQ
            (%<if_label>s)
            D=-1
            (%<else_label>s)
            @SP
            A=M
            M=D
            @SP
            M=M+1
        }.strip

        def initialize(operation)
          @operation = operation
        end

        def to_asm
          format(
            OPERATION_TEMPLATE,
            if_label: if_label,
            else_label: else_label,
            operation: operation.upcase
          )
        end

        def self.operations
          %w[gt lt eq]
        end

        private

        def if_label
          @if_label ||= IF_PREFIX + SecureRandom.hex(10)
        end

        def else_label
          @else_label ||= ELSE_PREFIX + SecureRandom.hex(10)
        end
      end
    end
  end
end
