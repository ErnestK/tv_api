class AddSearchIndexToContent < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pg_trgm'

    add_index :contents, 
              "to_tsvector('english', coalesce(original_name, '') || ' ' || coalesce(year::text, ''))",
              using: :gin,
              name: 'idx_content_search'
  end
end
