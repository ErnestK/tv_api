# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProviderApp, type: :model do
  let(:provider_app) { create(:provider_app) }

  it 'has content association' do
    expect(provider_app.content).to be_present
    expect(provider_app.content.contentable).to eq provider_app
  end

  it 'creates with content using factory method' do
    provider_app = described_class.create_with_content!({}, { original_name: 'Test App' })

    expect(provider_app.content.original_name).to eq 'Test App'
  end
end
