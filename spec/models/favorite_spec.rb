# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:favorite) { create(:favorite) }

  it 'belongs to user and content' do
    expect(favorite.user).to be_present
    expect(favorite.content).to be_present
  end

  it 'validates uniqueness of user and content combination' do
    user = create(:user)
    content = create(:movie).content
    create(:favorite, user: user, content: content)

    expect do
      create(:favorite, user: user, content: content)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
