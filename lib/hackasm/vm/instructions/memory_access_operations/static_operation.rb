module Vm
  module Instructions
    module MemoryAccessOperations
      class StaticOperation

        attr_reader :object_name, :index

        def initialize(object_name, index)
          @index = index
          @object_name = object_name
        end

        def to_asm
          if operation == "push"
            %Q{
              @#{object_name}.#{index}
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
              @#{object_name}.#{index}
              M=D
            }.strip
          end
        end

        def self.segments
          %w[static]
        end
      end
    end
  end
end
