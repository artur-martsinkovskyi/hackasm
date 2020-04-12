RSpec.describe "`hackasm asm2binary` command", type: :cli do
  it "executes `hackasm help asm2binary` command successfully" do
    output = `hackasm help asm2binary`
    expected_output = <<-OUT
Usage:
  hackasm asm2binary FILE

Options:
  -h, [--help], [--no-help]  # Display usage information

Translate *.asm file of assembler commands to *.hack file of binary commands
    OUT

    expect(output).to eq(expected_output)
  end
end
