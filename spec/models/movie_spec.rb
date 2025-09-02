# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) { create(:movie) }

  it 'has polymorphic content association' do
    expect(movie.content).to be_present
    expect(movie.content.contentable).to eq movie
  end

  describe 'destruction' do
    let!(:movie_to_destroy) { create(:movie) }

    it 'destroys content when destroyed' do
      expect { movie_to_destroy.destroy! }.to change(Content, :count).by(-1)
    end
  end
end
