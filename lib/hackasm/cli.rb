# frozen_string_literal: true

require 'thor'

module Hackasm
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'hackasm version'
    def version
      require_relative 'version'
      puts "v#{Hackasm::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'vm2asm', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def vm2asm(base_path)
      if options[:help]
        invoke :help, ['vm2asm']
      else
        require_relative 'commands/vm2asm'
        Hackasm::Commands::Vm2Asm.new(base_path, options).execute
      end
    end

    desc 'asm2binary FILE', 'Translate *.asm file to *.hack binary commands'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def asm2binary(file)
      if options[:help]
        invoke :help, ['asm2binary']
      else
        require_relative 'commands/asm2binary'
        Hackasm::Commands::Asm2Binary.new(file, options).execute
      end
    end
  end
end
