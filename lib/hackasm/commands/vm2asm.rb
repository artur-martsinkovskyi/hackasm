# frozen_string_literal: true

require_relative '../command'
require_relative '../vm/translator'

module Hackasm
  module Commands
    class Vm2Asm < Hackasm::Command
      attr_reader :base_path

      def initialize(base_path, options)
        @base_path = base_path
        @options = options
      end

      def execute(output: $stdout)
        if File.directory?(base_path)
          assembler_code = Dir[File.join(base_path, '*')].inject do |code_buffer, path|
            object_name = File.basename(path, '.vm')
            vm_code = File.read(path)
            code_buffer + Vm::Translator.new(vm_code, object_name).translate
          end
          file_name = "#{base_path}.asm"
        else
          object_name = File.basename(base_path, '.vm')
          vm_code = File.read(base_path)
          assembler_code = Vm::Translator.new(vm_code, object_name).translate
          file_name = File.join(File.dirname(base_path), "#{object_name}.asm")
        end

        output.puts assembler_code
        File.write(file_name, assembler_code)
      end
    end
  end
end
