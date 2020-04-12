RSpec.describe "`hackasm assemble` command", type: :cli do
  it "executes `hackasm help assemble` command successfully" do
    output = `hackasm help assemble`
    expected_output = <<-OUT
Usage:
  hackasm assemble

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
