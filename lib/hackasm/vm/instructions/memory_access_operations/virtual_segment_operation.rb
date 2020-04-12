module Vm
  module Instructions
    module MemoryAccessOperations
      class VirtualSegmentOperation
        VIRTUAL_SEGMENT_TO_POINTER_NAME = {
          'argument' => 'ARG',
          'local' => 'LCL',
          'this' => 'THIS',
          'that' => 'THAT',
        }.freeze


        attr_reader :operation, :segment, :index

        def initialize(operation, segment, index)
          @operation = operation
          @segment = segment
          @index = index
        end

        def to_asm
          if operation == "push"
            %Q{
              @#{index}
              D=A
              @#{VIRTUAL_SEGMENT_TO_POINTER_NAME[segment]}
              A=M+D
              D=M
              @SP
              A=M
              M=D
              @SP
              M=M+1
            }.strip
          else
            %Q{
              @SP
              M=M-1
              @SP
              A=M
              D=M
              @R14
              M=D
              @#{index}
              D=A
              @#{VIRTUAL_SEGMENT_TO_POINTER_NAME[segment]}
              D=M+D
              @R15
              M=D
              @R14
              D=M
              @R15
              A=M
              M=D
            }.strip
          end
        end

        def self.segments
          VIRTUAL_SEGMENT_TO_POINTER_NAME.keys
        end
      end
    end
  end
end
