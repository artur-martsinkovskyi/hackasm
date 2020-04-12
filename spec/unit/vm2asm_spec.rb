require 'hackasm/commands/vm2asm'

RSpec.describe Hackasm::Commands::Vm2asm do
  it "executes `vm2asm` command successfully" do
    output = StringIO.new
    options = {}
    command = Hackasm::Commands::Vm2asm.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
