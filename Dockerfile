from alpine:latest as base

WORKDIR /app

from base as dependencies

COPY requirements.txt ./

RUN apk add --no-cache python3-dev

RUN apk update

RUN apk add py-pip

RUN pip3 install --upgrade pip

RUN pip --no-cache-dir install -r requirements.txt

FROM dependencies AS build  
WORKDIR /app
COPY . /app

FROM python:3.6-alpine3.7 AS release  

WORKDIR /app

COPY --from=dependencies /app/requirements.txt ./
COPY --from=dependencies /root/.cache /root/.cache

RUN pip install -r requirements.txt

COPY --from=build /app/ ./
EXPOSE 5000

ENTRYPOINT ["python3"]
CMD ["app.py"]


