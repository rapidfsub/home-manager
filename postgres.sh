#!/bin/zsh
docker run -itd --restart unless-stopped -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres
