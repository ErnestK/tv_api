# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, type: :model do
  it 'validates name and code uniqueness' do
    create(:country, name: 'USA', code: 'US')

    duplicate = build(:country, name: 'USA', code: 'US')
    expect(duplicate).not_to be_valid
  end

  it 'has availability association' do
    country = create(:country)
    availability = create(:availability, country: country)

    expect(country.availability).to include availability
  end
end
