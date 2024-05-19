# Progress Tracker

<div style="display: flex; gap: .5rem;">
  <a href="https://docs.docker.com/">
    <img src="https://img.shields.io/badge/docker-blue?style=for-the-badge&logo=docker&logoColor=white"/>
  </a>
  <a href="https://elixir-lang.org/">
    <img src="https://img.shields.io/badge/elixir-purple?style=for-the-badge&logo=elixir&logoColor=white"/>
  </a>
  <a href="https://www.postgresql.org/docs/">
    <img src="https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white">
  </a>
  <p>
    <img src="https://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
  </p>
</div>

## Requirements
  - [Docker](https://www.docker.com)

## Start the application
To start your Phoenix server, all you have to do is run a docker compose command on your terminal:

```
docker compose up
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Run tests
After the application has started, run:

```bash
docker compose exec app bash -c "mix test"
```
