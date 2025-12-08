# Scripting Project F2025

- Course: Langage de script | 420-LS3-AS
- Author: Anh Hoang Nguyen 

# Demo

https://scripting-project-f2025.aaanh.app/

## Requirements

### Local development

- python >= 3.14
- pipenv

### Deployment

- Docker Engine

## Quick start

### Local development

- Install python v3.14 by one of the following ways:
  - Install directly from download
  - Install with pyenv `pyenv install 3.14 && pyenv global 3.14`, then restart the shell

- Install pyenv
  - Install from pip after pyenv (recommended): pip install --user pipenv
  - Install from brew `brew install pyenv`

- Start virtual environment

```sh
# at project root
pipenv shell
```

- Install dependencies

```sh
pipenv install
```

- Start development server

```sh
./start-dev.sh
```

### Deployment to production

```sh
docker compose up -d --build
```

## Production configurations

- Deploy with Docker on production server
- Use Cloudflare Tunnel to forward application port and proxy to friendly domain
