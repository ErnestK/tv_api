# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Content, type: :model do
  let(:content) { build(:content) }

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
    movie = create(:movie)
    content = create(:content, contentable: movie)

    expect(content.contentable_type).to eq 'Movie'
    expect(content.contentable).to eq movie
  end

  it 'enforces uniqueness per contentable' do
    movie = create(:movie)
    create(:content, contentable: movie)

    expect do
      create(:content, contentable: movie)
    end.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
