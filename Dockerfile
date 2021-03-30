from alpine:latest

RUN apk add --no-cache python3-dev

RUN apk update

RUN apk add py-pip

RUN pip3 install --upgrade pip

WORKDIR /app

COPY . /app

RUN pip --no-cache-dir install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python3"]
CMD ["app.py"]


