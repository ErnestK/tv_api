# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  it 'has associations to favorites and most_watched' do
    favorite = user.favorites.create!(content: movie.content)
    most_watched = user.most_watched.create!(content: movie.content, time_overall: 3600)

    expect(user.favorites).to include favorite
    expect(user.most_watched).to include most_watched
  end

  it 'validates name presence' do
    user = build(:user, name: nil)

    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end
end
