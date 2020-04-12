require "spec_helper"
require_relative "../../../lib/hackasm/assembler/translator"

RSpec.describe Assembler::Translator do
  it "translates Add program properly" do
    expect(described_class.new(File.read(__dir__ + "/../../support/assembled_examples/Add.asm")).translate).to eq(File.read(__dir__ + "/../../support/assembled_examples/Add.hack"))
  end

  it "translates Rect program properly" do
    expect(described_class.new(File.read(__dir__ + "/../../support/assembled_examples/Rect.asm")).translate).to eq(File.read(__dir__ + "/../../support/assembled_examples/Rect.hack"))
  end


  it "translates Pong program properly" do
    expect(described_class.new(File.read(__dir__ + "/../../support/assembled_examples/Pong.asm")).translate).to eq(File.read(__dir__ + "/../../support/assembled_examples/Pong.hack"))
  end
end
