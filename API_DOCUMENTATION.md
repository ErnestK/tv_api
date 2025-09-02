# TV API Documentation

## Base URL
```
http://localhost:3000/api/v1
```

## Authentication
No authentication required for this version.

## Endpoints

### 1. Get Filtered Content
**GET** `/contents`

Filter content by country and optionally by type.

**Parameters:**
- `country` (required): Country code (US, GB, ES)
- `type` (optional): Content type (movie, tv_show, channel, provider_app, etc.)

**Example:**
```bash
GET /api/v1/contents?country=US&type=movie
```

**Response:**
```json
{
  "result": [
    {
      "original_name": "Interstellar",
      "year": 2014,
      "created_at": "2025-09-02T12:30:45.123Z",
      "content": {
        "id": 1,
        "type": "Movie"
      }
    }
  ]
}
```

### 2. Search Content
**GET** `/contents/search`

Search content by title, year, or partial text.

**Parameters:**
- `q` (required): Search query

**Example:**
```bash
GET /api/v1/contents/search?q=Interstellar
GET /api/v1/contents/search?q=2014
GET /api/v1/contents/search?q=Net  # partial search
```

**Response:**
```json
{
  "result": [
    {
      "original_name": "Interstellar",
      "year": 2014,
      "created_at": "2025-09-02T12:30:45.123Z",
      "content": {
        "id": 1,
        "type": "Movie"
      }
    }
  ]
}
```

### 3. Get Movie Details
**GET** `/movies/:id`

**Parameters:**
- `id` (required): Movie ID

**Example:**
```bash
GET /api/v1/movies/1
```

**Response:**
```json
{
  "result": {
    "id": 1,
    "duration_in_seconds": 7200,
    "title": "Interstellar",
    "year": 2014,
    "created_at": "2025-09-02T12:30:45.123Z"
  }
}
```

### 4. Get TV Show Details
**GET** `/tv_shows/:id`

**Parameters:**
- `id` (required): TV Show ID

**Example:**
```bash
GET /api/v1/tv_shows/1
```

**Response:**
```json
{
  "result": {
    "id": 1,
    "title": "Breaking Bad",
    "year": 2008,
    "created_at": "2025-09-02T12:30:45.123Z"
  }
}
```

### 5. Get Season Details
**GET** `/tv_shows_seasons/:id`

**Parameters:**
- `id` (required): Season ID

**Example:**
```bash
GET /api/v1/tv_shows_seasons/1
```

**Response:**
```json
{
  "result": {
    "id": 1,
    "tv_show_id": 1,
    "number": 1,
    "title": "Breaking Bad Season 1",
    "year": 2008,
    "created_at": "2025-09-02T12:30:45.123Z"
  }
}
```

### 6. Get Episode Details
**GET** `/tv_shows_seasons_episodes/:id`

**Parameters:**
- `id` (required): Episode ID

**Example:**
```bash
GET /api/v1/tv_shows_seasons_episodes/1
```

**Response:**
```json
{
  "result": {
    "id": 1,
    "tv_shows_season_id": 1,
    "number": 1,
    "duration_in_seconds": 3480,
    "title": "Pilot",
    "year": 2008,
    "created_at": "2025-09-02T12:30:45.123Z"
  }
}
```

### 7. Get Channel Details
**GET** `/channels/:id`

**Parameters:**
- `id` (required): Channel ID

**Example:**
```bash
GET /api/v1/channels/1
```

**Response:**
```json
{
  "result": {
    "id": 1,
    "title": "HBO",
    "year": null,
    "created_at": "2025-09-02T12:30:45.123Z"
  }
}
```

### 8. Get Channel Program Details
**GET** `/channel_programs/:id`

**Parameters:**
- `id` (required): Channel program ID
- `user_id` (optional): User ID for personalized time watched

**Example:**
```bash
GET /api/v1/channel_programs/1
GET /api/v1/channel_programs/1?user_id=5
```

**Response:**
```json
{
  "result": {
    "id": 1,
    "channel_id": 1,
    "schedule": [
      "2024-01-01 20:00:00 UTC..2024-01-01 22:00:00 UTC",
      "2024-01-02 20:00:00 UTC..2024-01-02 22:00:00 UTC"
    ],
    "title": "Game of Thrones Rerun",
    "year": null,
    "time_watched": 3600,
    "created_at": "2025-09-02T12:30:45.123Z"
  }
}
```

### 9. Get Provider App Details
**GET** `/provider_apps/:id`

**Parameters:**
- `id` (required): Provider App ID

**Example:**
```bash
GET /api/v1/provider_apps/1
```

**Response:**
```json
{
  "result": {
    "id": 1,
    "name": "Netflix Mobile App",
    "year": 2023,
    "created_at": "2025-09-02T12:30:45.123Z"
  }
}
```

### 10. Get User Favorite Channel Programs
**GET** `/users/:id/favorite_channel_programs`

Returns user's favorite channel programs ordered by time watched (descending).

**Parameters:**
- `id` (required): User ID

**Example:**
```bash
GET /api/v1/users/5/favorite_channel_programs
```

**Response:**
```json
{
  "result": [
    {
      "id": 1,
      "channel_id": 1,
      "schedule": ["2024-01-01 20:00:00 UTC..2024-01-01 22:00:00 UTC"],
      "title": "Game of Thrones Rerun",
      "year": null,
      "time_watched": 7200,
      "created_at": "2025-09-02T12:30:45.123Z",
      "updated_at": "2025-09-02T12:35:20.456Z"
    }
  ]
}
```

### 11. Get User Favorite Provider Apps
**GET** `/users/:id/favorite_provider_apps`

Returns user's favorite provider apps ordered by position.

**Parameters:**
- `id` (required): User ID

**Example:**
```bash
GET /api/v1/users/5/favorite_provider_apps
```

**Response:**
```json
{
  "result": [
    {
      "id": 1,
      "name": "Netflix Mobile App",
      "year": 2023,
      "position": 1,
      "created_at": "2025-09-02T12:30:45.123Z",
      "updated_at": "2025-09-02T12:35:20.456Z"
    }
  ]
}
```

### 12. Add Provider App to Favorites
**POST** `/users/:id/favorite_provider_app`

**Parameters:**
- `id` (required): User ID

**Example:**
```bash
POST /api/v1/users/5/favorite_provider_app
Content-Type: application/json

{
  "favorite": {
    "provider_app_id": 1,
    "order_num": 2
  }
}
```

**Success Response:**
```json
{
  "result": {
    "message": "Provider app favorited successfully"
  }
}
```

**Error Response:**
```json
{
  "error": "Validation failed",
  "message": ["Order num has already been taken"]
}
```
