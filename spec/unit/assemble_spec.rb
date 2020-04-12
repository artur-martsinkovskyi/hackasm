require 'hackasm/commands/assemble'

RSpec.describe Hackasm::Commands::Assemble do
  it "executes `assemble` command successfully" do
    output = StringIO.new
    options = {}
    command = Hackasm::Commands::Assemble.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
