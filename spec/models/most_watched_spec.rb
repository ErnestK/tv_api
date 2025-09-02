# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MostWatched, type: :model do
  let(:most_watched) { create(:most_watched) }

  it 'belongs to user and channel_program' do
    expect(most_watched.user).to be_present
    expect(most_watched.channel_program).to be_present
    expect(most_watched.time_overall).to be > 0
  end

  it 'validates uniqueness and time_overall' do
    user = create(:user)
    channel_program = create(:channel_program)
    create(:most_watched, user: user, channel_program: channel_program, time_overall: 3600)

    expect do
      create(:most_watched, user: user, channel_program: channel_program, time_overall: 1800)
    end.to raise_error(ActiveRecord::RecordInvalid)

    negative_time_record = build(:most_watched, time_overall: -100)
    expect(negative_time_record).to be_invalid
  end
end
