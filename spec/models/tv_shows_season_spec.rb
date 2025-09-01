# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TvShowsSeason, type: :model do
  it 'belongs to tv_show and has content' do
    season = create(:tv_shows_season)

    expect(season.tv_show).to be_present
    expect(season.content).to be_present
  end

  it 'validates unique number per tv_show' do
    tv_show = create(:tv_show)
    create(:tv_shows_season, tv_show: tv_show, number: 1)

    expect do
      create(:tv_shows_season, tv_show: tv_show, number: 1)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
