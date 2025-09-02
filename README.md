# TV API - Streaming Content Management System

A Ruby on Rails API for managing streaming content including movies, TV shows, channels, and provider apps with advanced search and user personalization features.

## 🚀 Quick Start

### Database Setup
PostgreSQL runs in Docker container:

```bash
docker-compose up -d
bin/rails db:create db:migrate db:seed
```

**Note:** Database runs on port `5433` instead of default `5432` to prevent conflicts with existing PostgreSQL installations.

## 🏗️ Database Architecture

The system uses a sophisticated polymorphic architecture centered around a `Content` table:

```
Content (Polymorphic Hub)
├── Movies
├── TV Shows → Seasons → Episodes  
├── Channels → Channel Programs
└── Provider Apps

User Activity
├── Favorites (Provider Apps + Position)
└── Most Watched (Channel Programs + Time)

Availability (Content ↔ Apps ↔ Countries)
```

**📊 Complete database schema:** [DATABASE_SCHEMA.dbml](./DATABASE_SCHEMA.dbml) (compatible with [dbdiagram.io](https://dbdiagram.io/d))

### Key Design Decisions

**Polymorphic Content Table** - centralized solution that enables:
- ✅ **Unified search** across all content types
- ✅ **Consistent metadata** (title, year) for all entities
- ✅ **Easy extensibility** - add new content types without schema changes
- ✅ **Simplified relationships** - one table to rule them all

## 🔍 Advanced Search

**Full-text search** powered by PostgreSQL without additional fields:

```sql
-- GIN index on computed tsvector
CREATE INDEX idx_content_search ON contents 
USING gin(to_tsvector('english', coalesce(original_name, '') || ' ' || coalesce(year::text, '')));
```

**Features:**
- ✅ **Full-text search**: `"Interstellar"` → finds exact matches
- ✅ **Year search**: `"2008"` → finds all 2008 content  
- ✅ **Partial search**: `"Inter"` → finds "Interstellar"
- ✅ **Multi-word search**: `"Dark Knight"` → intelligent matching

## 🎯 Extensible Favorites System

Current implementation supports favorites for Provider Apps and watch history for Channel Programs as required.
However, the architecture easily supports **favorites for ANY content type**:

```ruby
# Current (specific)
user.favorites → provider_apps only
user.most_watched → channel_programs only

# Potential (universal) - just add content_id:
user.favorites → any content (movies, shows, episodes, etc.)
user.most_watched → any content with time tracking
```

**Easy migration path:** Add `content_id` to favorites/most_watched tables to enable universal content favoriting.

## 📊 Technical Highlights

- **PostgreSQL Advanced Features**: JSONB, tstzrange arrays, GIN indexes, GIST indexes
- **Optimized Queries**: Bullet-tested, zero N+1 queries
- **Clean Architecture**: Concerns, polymorphic associations, proper separation
- **Comprehensive Testing**: 70+ RSpec tests covering all scenarios
- **Code Quality**: RuboCop compliant, well-documented

## 📚 API Documentation

Comprehensive API documentation available in multiple formats:

- **Interactive**: [Apipie Web Interface](http://localhost:3000/apipie)
- **Detailed**: [API_DOCUMENTATION.md](./API_DOCUMENTATION.md) - Complete examples and usage
- **Quick Reference**: Generated via `bundle exec rake routes`

## 🛠️ Development

```bash
# Setup
bundle install
docker-compose up -d
bin/rails db:setup

# Testing  
bundle exec rspec
bundle exec rubocop

# Start server
bin/rails server

# API Documentation
open http://localhost:3000/apipie
```

## 📋 API Endpoints Summary

- **Content Filtering**: `GET /api/v1/contents?country=US&type=movie`
- **Search**: `GET /api/v1/contents/search?q=Interstellar`
- **Show Endpoints**: Individual content details for all 7 types
- **User Favorites**: Channel programs (by watch time) & Provider apps (by position)
- **Favoriting**: Add apps to favorites with custom positioning

**All endpoints return consistent JSON structure with `result` wrapper and proper error handling.**
