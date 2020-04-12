module Vm
  module Instructions
    module MemoryAccessOperations
      class FixedSegmentOperation
        FIXED_SEGMENT_TO_START_INDEX = {
          'temp' => '5',
          'pointer' => '3',
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
              @#{FIXED_SEGMENT_TO_START_INDEX[segment]}
              A=A+D
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
              @#{FIXED_SEGMENT_TO_START_INDEX[segment]}
              D=A+D
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
          FIXED_SEGMENT_TO_START_INDEX.keys
        end
      end
    end
  end
end
