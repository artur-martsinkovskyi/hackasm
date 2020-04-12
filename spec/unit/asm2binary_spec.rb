require 'hackasm/commands/asm2binary'

RSpec.describe Hackasm::Commands::Asm2Binary do
  it "executes `asm2binary` command successfully" do
    output = StringIO.new
    options = {}
    filename = __dir__ + "/../support/assembler_examples/Add.asm"

    expected_output = File.read(__dir__ + "/../support/assembler_examples/Add.hack")

    command = Hackasm::Commands::Asm2Binary.new(filename, options)

    expect(File).to receive(:write).with(described_class::FILE_NAME, expected_output)

    command.execute(output: output)

    expect(output.string).to eq(expected_output)
  end
end
