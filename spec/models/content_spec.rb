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
end
