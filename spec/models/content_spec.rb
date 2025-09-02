# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Content, type: :model do
  let(:movie) { create(:movie) }
  let(:content) { build(:content, contentable: movie) }

  it 'validates required fields' do
    content.original_name = nil
    expect(content).not_to be_valid
    expect(content.errors[:original_name]).to include("can't be blank")
  end

  it 'validates original_name length' do
    content.original_name = 'a' * 256
    expect(content).not_to be_valid
  end

  it 'works with polymorphic association' do
    content = movie.content

    expect(content.contentable_type).to eq 'Movie'
    expect(content.contentable).to be_a(Movie)
  end

  it 'enforces uniqueness per contentable' do
    movie = create(:movie)

    expect do
      described_class.create!(contentable: movie, original_name: 'Duplicate')
    end.to raise_error(ActiveRecord::RecordNotUnique)
  end

  describe 'search functionality' do
    let!(:interstellar) { create(:movie).tap { |m| m.content.update!(original_name: 'Interstellar', year: 2014) } }
    let!(:dark_knight) { create(:movie).tap { |m| m.content.update!(original_name: 'The Dark Knight', year: 2008) } }
    let!(:netflix_app) { create(:app).tap { |a| a.content.update!(original_name: 'Netflix Mobile App', year: 2023) } }

    it 'searches by title' do
      results = described_class.search('Interstellar')
      expect(results).to include(interstellar.content)
      expect(results).not_to include(dark_knight.content)
    end

    it 'searches by title for app' do
      results = described_class.search('Netflix')
      expect(results).to include(netflix_app.content)
      expect(results).not_to include(dark_knight.content)
    end

    it 'searches by year' do
      results = described_class.search('2008')
      expect(results).to include(dark_knight.content)
      expect(results).not_to include(interstellar.content)
    end

    it 'searches by partial title' do
      results = described_class.search('Dark')
      expect(results).to include(dark_knight.content)
    end

    it 'returns all when query is blank' do
      expect(described_class.search('')).to eq(described_class.all)
      expect(described_class.search(nil)).to eq(described_class.all)
    end

    it 'searches by title and year combined' do
      results = described_class.search('Interstellar 2014')
      expect(results).to include(interstellar.content)
      expect(results).not_to include(dark_knight.content)
    end
  end
end
