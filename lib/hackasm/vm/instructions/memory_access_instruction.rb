require_relative './memory_access_operations/static_operation'
require_relative './memory_access_operations/constant_operation'
require_relative './memory_access_operations/fixed_segment_operation'
require_relative './memory_access_operations/virtual_segment_operation.rb'

module Vm
  module Instructions
    class MemoryAccessInstruction
      attr_reader :segment, :operation, :index, :object_name

      def initialize(instruction, object_name)
        @segment = instruction[:segment].to_s
        @operation = instruction[:operation].to_s
        @index = instruction[:index].to_s
        @object_name = object_name
      end

      def to_asm
        comment + case segment
        when *MemoryAccessOperations::ConstantOperation.segments
          MemoryAccessOperations::ConstantOperation.new(index).to_asm
        when *MemoryAccessOperations::StaticOperation.segments
          MemoryAccessOperations::StaticOperation.new(index, object_name).to_asm
        when *MemoryAccessOperations::VirtualSegmentOperation.segments
          MemoryAccessOperations::VirtualSegmentOperation.new(operation, segment, index).to_asm
        when *MemoryAccessOperations::FixedSegmentOperation.segments
          MemoryAccessOperations::FixedSegmentOperation.new(operation, segment, index).to_asm
        end.split("\n").map(&:strip).join("\n")
      end

      def comment
        "// #{operation} #{segment} #{index}\n"
      end
    end
  end
end
