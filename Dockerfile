FROM python:3.12-slim
LABEL maintainer="ldg55d@gmail.com"

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && \
  apt-get install -y --no-install-recommends gcc git wget curl

# manage dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY . /app/
COPY env/dev.env /app/.env

RUN wget -q -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_aarch64
RUN chmod +x /usr/local/bin/dumb-init

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
