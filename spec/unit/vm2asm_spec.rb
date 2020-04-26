# frozen_string_literal: true

require 'hackasm/commands/vm2asm'

RSpec.describe Hackasm::Commands::Vm2Asm do
  before do
  end

  it 'executes `vm2asm` command successfully' do
    output = StringIO.new
    options = {}
    filename = __dir__ + '/../support/vm_examples/Add.vm'
    vm_code_filename = __dir__ + '/../support/vm_examples/Add.asm'
    expected_output = File.read(vm_code_filename)
    command = Hackasm::Commands::Vm2Asm.new(filename, options)

    expect(File).to receive(:write).with(vm_code_filename, expected_output)

    command.execute(output: output)

    expect(output.string).to eq(expected_output)
  end
end
