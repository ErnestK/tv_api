# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Availability, type: :model do
  it 'belongs to content, app and country' do
    availability = create(:availability)

    expect(availability.content).to be_present
    expect(availability.app).to be_present
    expect(availability.country).to be_present
  end

  it 'validates uniqueness of content per app and country' do
    movie = create(:movie)
    app = create(:app)
    country = create(:country)

    create(:availability, content: movie.content, app: app, country: country)

    expect do
      create(:availability, content: movie.content, app: app, country: country)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
