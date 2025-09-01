# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'has polymorphic content association' do
    movie = create(:movie)

    expect(movie.content).to be_present
    expect(movie.content.contentable).to eq movie
  end

  it 'destroys content when destroyed' do
    movie = create(:movie)

    expect { movie.destroy! }.to change(Content, :count).by(-1)
  end
end
