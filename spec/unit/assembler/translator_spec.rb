# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/hackasm/assembler/translator'

RSpec.describe Assembler::Translator do
  it 'translates Add program properly' do
    expect(
      described_class.new(File.read(__dir__ + '/../../support/assembler_examples/Add.asm')).translate
    ).to eq(File.read(__dir__ + '/../../support/assembler_examples/Add.hack'))
  end

  it 'translates Rect program properly' do
    expect(
      described_class.new(File.read(__dir__ + '/../../support/assembler_examples/Rect.asm')).translate
    ).to eq(File.read(__dir__ + '/../../support/assembler_examples/Rect.hack'))
  end

  it 'translates Pong program properly' do
    expect(
      described_class.new(File.read(__dir__ + '/../../support/assembler_examples/Pong.asm')).translate
    ).to eq(File.read(__dir__ + '/../../support/assembler_examples/Pong.hack'))
  end
end
