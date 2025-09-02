# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel, type: :model do
  let(:channel) { create(:channel) }

  it 'has content and programs associations' do
    program = create(:channel_program, channel: channel)

    expect(channel.content).to be_present
    expect(channel.channel_programs).to include program
  end

  describe 'destruction' do
    it 'destroys programs when destroyed' do
      channel_to_destroy = create(:channel)
      create(:channel_program, channel: channel_to_destroy)

      expect { channel_to_destroy.destroy! }.to change(ChannelProgram, :count).by(-1)
    end
  end
end
