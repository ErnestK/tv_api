# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelProgram, type: :model do
  let(:program) { create(:channel_program) }

  it 'belongs to channel and has content' do
    expect(program.channel).to be_present
    expect(program.content).to be_present
  end

  it 'validates time_range presence' do
    program = build(:channel_program, time_range: nil)

    expect(program).not_to be_valid
    expect(program.errors[:time_range]).to include("can't be blank")
  end
end
