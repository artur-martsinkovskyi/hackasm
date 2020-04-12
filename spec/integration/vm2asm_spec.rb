RSpec.describe "`hackasm vm2asm` command", type: :cli do
  it "executes `hackasm help vm2asm` command successfully" do
    output = `hackasm help vm2asm`
    expected_output = <<-OUT
Usage:
  hackasm vm2asm FILE

Options:
  -h, [--help], [--no-help]  # Display usage information

Translate *.vm file with virtual machine code or a folder of *.vm files to the single *.asm file of assembler commands
    OUT

    expect(output).to eq(expected_output)
  end
end
