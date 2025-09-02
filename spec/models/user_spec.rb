# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  it 'has associations to favorites and most_watched' do
    provider_app = create(:provider_app)
    channel_program = create(:channel_program)

    favorite = user.favorites.create!(provider_app: provider_app, order_num: 1)
    most_watched = user.most_watched.create!(channel_program: channel_program, time_overall: 3600)

    expect(user.favorites).to include favorite
    expect(user.most_watched).to include most_watched
  end

  it 'validates name presence' do
    user = build(:user, name: nil)

    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end
end
