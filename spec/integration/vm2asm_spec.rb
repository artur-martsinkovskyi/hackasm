RSpec.describe "`hackasm vm2asm` command", type: :cli do
  it "executes `hackasm help vm2asm` command successfully" do
    output = `hackasm help vm2asm`
    expected_output = <<-OUT
Usage:
  hackasm vm2asm

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
