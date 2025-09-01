# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel, type: :model do
  it 'has content and programs associations' do
    channel = create(:channel)
    program = create(:channel_program, channel: channel)

    expect(channel.content).to be_present
    expect(channel.channel_programs).to include program
  end

  it 'destroys programs when destroyed' do
    channel = create(:channel)
    create(:channel_program, channel: channel)

    expect { channel.destroy! }.to change(ChannelProgram, :count).by(-1)
  end
end
