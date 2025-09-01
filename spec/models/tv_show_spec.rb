# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TvShow, type: :model do
  it 'has content and seasons associations' do
    tv_show = create(:tv_show)
    season = create(:tv_shows_season, tv_show: tv_show)

    expect(tv_show.content).to be_present
    expect(tv_show.tv_shows_seasons).to include season
  end

  it 'creates with content using factory method' do
    tv_show = described_class.create_with_content!({ year: 2020 }, { original_name: 'Test Show' })

    expect(tv_show.content.original_name).to eq 'Test Show'
  end

  it 'destroys seasons when destroyed' do
    tv_show = create(:tv_show)
    create(:tv_shows_season, tv_show: tv_show)

    expect { tv_show.destroy! }.to change(TvShowsSeason, :count).by(-1)
  end
end
