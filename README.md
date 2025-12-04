# shortlink-ruby

A simple URL shortener implemented with **Ruby**, **Sinatra**, **SQLite**, and **Sequel**.  
Provides two JSON endpoints:

- `POST /encode` – shorten a long URL
- `POST /decode` – resolve a short code back to the original URL

---

## 🚀 Setup & Run

### Install dependencies

```bash
bundle install
```

### Initialize database

```bash
ruby scripts/init_db.rb
```

### Start server

```bash
bundle exec ruby app.rb
```

Service runs at: `http://localhost:4567`

---

## 🧪 Tests

```bash
bundle exec rspec
```

---

## 📌 API

### POST `/encode`

**Request**

```json
{ "url": "https://example.com" }
```

**Response**

```json
{ "code": "Ab3d", "url": "https://example.com" }
```

### POST `/decode`

**Request**

```json
{ "code": "Ab3d" }
```

**Response**

```json
{ "code": "Ab3d", "url": "https://example.com" }
```

---

## 🧠 Design

- IDs are auto-incremented in SQLite
- Each ID is obfuscated using XOR + encoded in **Base62**
- Code is unique and deterministic (no collisions)
- The service reuses the same short code for duplicate URLs.
- Logic separated into:
  - `app.rb` – routes
  - `lib/shortener.rb` – Base62 + obfuscation
  - `config/database.rb` – DB connection
  - `scripts/init_db.rb` – schema creation

---

## 🔐 Notes

- Basic validation: URL must start with `http://` or `https://`
- Errors return JSON: `400` (invalid input) / `404` (not found)

---

## 📈 Future Improvements (optional)

- Add redirect endpoint `GET /:code`
- Add caching (Redis)
- Add click analytics
- Move SQLite → PostgreSQL if scaling
