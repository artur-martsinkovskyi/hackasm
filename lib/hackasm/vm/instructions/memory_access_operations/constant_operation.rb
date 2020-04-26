# frozen_string_literal: true

module Vm
  module Instructions
    module MemoryAccessOperations
      class ConstantOperation
        attr_reader :index

        def initialize(index)
          @index = index
        end

        def to_asm
          %(
            @#{index}
            D=A
            @SP
            A=M
            M=D
            @SP
            M=M+1
          ).strip
        end

        def self.segments
          %w[constant]
        end
      end
    end
  end
end
