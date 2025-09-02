# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:favorite) { create(:favorite) }

  it 'belongs to user and provider_app' do
    expect(favorite.user).to be_present
    expect(favorite.provider_app).to be_present
    expect(favorite.order_num).to be_present
  end

  it 'validates uniqueness of user and provider_app combination' do
    user = create(:user)
    provider_app = create(:provider_app)
    create(:favorite, user: user, provider_app: provider_app, order_num: 1)

    expect do
      create(:favorite, user: user, provider_app: provider_app, order_num: 2)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'validates uniqueness of order_num per user' do
    user = create(:user)
    create(:favorite, user: user, order_num: 1)

    expect do
      create(:favorite, user: user, order_num: 1)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
