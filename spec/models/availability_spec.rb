# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Availability, type: :model do
  let(:availability) { create(:availability) }

  it 'belongs to content, app and country' do
    expect(availability.content).to be_present
    expect(availability.provider_app).to be_present
    expect(availability.country).to be_present
  end

  it 'validates uniqueness of content per app and country' do
    movie = create(:movie)
    provider_app = create(:provider_app)
    country = create(:country)

    create(:availability, content: movie.content, provider_app: provider_app, country: country)

    expect do
      create(:availability, content: movie.content, provider_app: provider_app, country: country)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
