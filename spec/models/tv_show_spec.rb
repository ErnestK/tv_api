# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TvShow, type: :model do
  let(:tv_show) { create(:tv_show) }

  it 'has content and seasons associations' do
    season = create(:tv_shows_season, tv_show: tv_show)

    expect(tv_show.content).to be_present
    expect(tv_show.tv_shows_seasons).to include season
  end

  it 'creates with content using factory method' do
    tv_show = described_class.create_with_content!({}, { original_name: 'Test Show', year: 2020 })

    expect(tv_show.content.original_name).to eq 'Test Show'
  end

  describe 'destruction' do
    it 'destroys seasons when destroyed' do
      tv_show_to_destroy = create(:tv_show)
      create(:tv_shows_season, tv_show: tv_show_to_destroy)

      expect { tv_show_to_destroy.destroy! }.to change(TvShowsSeason, :count).by(-1)
    end
  end
end
