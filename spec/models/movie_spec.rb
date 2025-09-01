require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'has polymorphic content association' do
    movie = create(:movie)
    content = movie.create_content!(original_name: "Test Content")
    
    expect(movie.content).to eq content
    expect(content.contentable).to eq movie
  end

  it 'destroys content when destroyed' do
    movie = create(:movie_with_content)
    
    expect { movie.destroy! }.to change(Content, :count).by(-1)
  end
end 