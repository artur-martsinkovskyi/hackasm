require_relative "../constants/jumps"
require_relative "../constants/dests"

module Assembler
  module Instructions
    class CommandInstruction
      JUMPS_TABLE = [nil, *JUMPS].zip(
        (0..8).map { |i| i.to_s(2).rjust(3, "0") }
      ).to_h.freeze
      DESTS_TABLE = [nil, *DESTS].zip(
        (0..8).map { |i| i.to_s(2).rjust(3, "0") }
      ).to_h.freeze
      COMPS_TABLE = {
        "0"   => "0101010",
        "1"   => "0111111",
        "-1"  => "0111010",
        "D"   => "0001100",
        "A"   => "0110000",
        "!D"  => "0001101",
        "!A"  => "0110001",
        "-D"  => "0001111",
        "-A"  => "0110011",
        "D+1" => "0011111",
        "A+1" => "0110111",
        "D-1" => "0001110",
        "A-1" => "0110010",
        "D+A" => "0000010",
        "D-A" => "0010011",
        "A-D" => "0000111",
        "D&A" => "0000000",
        "D|A" => "0010101",
        "M"   => "1110000",
        "!M"  => "1110001",
        "-M"  => "1110011",
        "M+1" => "1110111",
        "M-1" => "1110010",
        "D+M" => "1000010",
        "D-M" => "1010011",
        "M-D" => "1000111",
        "D&M" => "1000000",
        "D|M" => "1010101",
      }

      def initialize(instruction)
        @instruction = instruction
      end

      def to_b
        comp_bits = COMPS_TABLE[comp]

        binary_instruction = "111"
        binary_instruction << COMPS_TABLE[comp]
        binary_instruction << DESTS_TABLE[dest]
        binary_instruction << JUMPS_TABLE[jump]

        binary_instruction
      rescue
        binding.pry
      end

      private

      def dest
        @instruction[:dest] && @instruction[:dest].to_s
      end

      def jump
        @instruction[:jump] && @instruction[:jump].to_s
      end

      def comp
        @instruction[:comp] && @instruction[:comp].to_s.tr(" ", "")
      end
    end
  end
end
