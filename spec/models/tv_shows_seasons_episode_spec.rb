# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TvShowsSeasonsEpisode, type: :model do
  let(:episode) { create(:tv_shows_seasons_episode) }

  it 'belongs to season and has content' do
    expect(episode.tv_shows_season).to be_present
    expect(episode.content).to be_present
  end

  it 'validates unique number per season' do
    season = create(:tv_shows_season)
    create(:tv_shows_seasons_episode, tv_shows_season: season, number: 1)

    expect do
      create(:tv_shows_seasons_episode, tv_shows_season: season, number: 1)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
