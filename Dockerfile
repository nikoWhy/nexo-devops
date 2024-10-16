FROM python:3.10

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN  pip install -r requirements.txt

COPY main.py .

USER 1000:1000

EXPOSE 8000

ENTRYPOINT [ "fastapi" ]

CMD ["run", "/app/main.py"]