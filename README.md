# URL Shortener – Technical Test Submission

This project was built for a backend technical test.  
It implements a simple URL shortening service.

---

## 🎯 Features

- **POST `/encode`**  
  Shortens a URL. Returns the **same code** for duplicate URLs.

- **POST `/decode`**  
  Resolves a short code back to the original URL.

- **GET `/:code`**  
  Optional 302 redirect to the original URL.

- **Sinatra Modular Architecture**
  - Controllers for HTTP routing
  - Services for business logic
  - Models wrapping Sequel dataset
  - Concerns for JSON + error helpers (DRY)

- **SQLite + Sequel ORM**  
- **Rackup + Puma** for running the app

---

## 📁 Folder Structure

```
app/
  controllers/    # Routing & HTTP handling
  services/       # Business logic
  models/         # Data access layer
  concerns/       # Shared helpers (JSON, errors)
config/           # Database setup
lib/              # Base62 + obfuscation
scripts/          # Init database
app.rb
config.ru
```

---

## 🚀 Run the Project

### Install dependencies
```
bundle install
```

### Initialize the database
```
ruby scripts/init_db.rb
```

### Start the server
```
bundle exec rackup -p 4567
```

Server will be available at:  
`http://localhost:4567`

---

## 📡 API Endpoints

### POST `/encode`
**Request**
```json
{ "url": "https://google.com" }
```

**Response**
```json
{ "code": "Ab3d", "url": "https://google.com" }
```

---

### POST `/decode`
**Request**
```json
{ "code": "Ab3d" }
```

**Response**
```json
{ "code": "Ab3d", "url": "https://google.com" }
```

---

### GET `/:code`
Redirects to the original URL (302).

---

## 🧪 Testing (optional)

Run RSpec:
```
bundle exec rspec
```

---

## 📌 Notes

This project focuses on:
- Clear and maintainable structure  
- Separation of concerns  
- A lightweight, test-friendly implementation for the technical test  

