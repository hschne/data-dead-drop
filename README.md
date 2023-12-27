# Data Dead Drop

Data Dead Drop is a platform for effortless, secure file sharing. Data self-destroys after access. No browser required - just use your favorite command line client.

## Usage

Visit https://datadeaddrop.com to upload data, or upload data via the command line, for example using Curl:

```bash
curl https://datadeaddrop.com/upload \
  -X POST -H "Accept: application/json" \
  -F "upload[data]=@file.txt" -F "upload[expiry]=10" -F "upload[uses]=3"
```

Uploaded data will automatically be deleted after the specified number of minutes or uses. The maximum expiry is 60 minutes, and the maximum number of uses is 10. File size is limited to 1MB.

Data Dead drop will return a unique link generated using the [Diceware algorithm](https://en.wikipedia.org/wiki/Diceware) method. Use this link to download the file in the browser or via the command line.

```bash
curl https://datadeaddrop.com/download/your-secret-key \
  -L -H "Accept: application/json" > "your-file.text"
```

### API Documentation

Data Dead Drop's API is simple. If you want to build your own client use the `/upload` and `/download` endpoints.

#### Upload

```json
# POST /upload
{
  "data":"file.txt",
  "expiry":10,
  "uses":1
}
```

A successful request will return status code `200` and the following payload: 

```json
{
  "name":"file.txt"
  "key":"your-secret-key",
  "url":"http://datadeaddrop/d/your-secret-key",
  "expiry":"2024-12-24T18:10:00.000Z",
  "uses":3,
  "created_at":"2023-12-24T18:00:00.000Z",
}
```

#### Download

```json
# GET /download/your-secret-key
```

## Development

This is a Ruby on Rails application. To get started, clone the repo, install dependencies and prepare the database. You'll also need to seed the database with a Diceware word list.

```bash
bundle install
rails db:setup
rake import:dice_words
```

The start the server with 

```bash
rails server
```

### Testing

Data Dead Drop uses RSpec for testing. Run the test suite with

```bash
bundle exec rspec
```

### Deployment

Data Dead Drop is automatically deployed via GitHub actions using [Kamal](https://kamal-deploy.org/). To manually deploy you'll need SSH access to the server and access to the Docker Hub registry.

```bash
kamal setup
kamal deploy
```
