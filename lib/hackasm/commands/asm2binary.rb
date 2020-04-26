# frozen_string_literal: true

require_relative '../command'
require_relative '../assembler/translator'

module Hackasm
  module Commands
    class Asm2Binary < Hackasm::Command
      FILE_NAME = 'a.hack'

      def initialize(file, options)
        @file = file
        @options = options
      end

      def execute(output: $stdout)
        assembler_code = File.read(@file)

        binary = Assembler::Translator.new(assembler_code).translate

        output.puts binary
        File.write(FILE_NAME, binary)
      end
    end
  end
end
