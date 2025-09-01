# frozen_string_literal: true

require 'rails_helper'

RSpec.describe App, type: :model do
  it 'has content association' do
    app = create(:app)

    expect(app.content).to be_present
    expect(app.content.contentable).to eq app
  end

  it 'creates with content using factory method' do
    app = described_class.create_with_content!({}, { original_name: 'Test App' })

    expect(app.content.original_name).to eq 'Test App'
  end
end
