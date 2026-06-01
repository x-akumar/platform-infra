FROM python:3.12-slim


RUN useradd -m appuser

WORKDIR /app

COPY app.py requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

USER appuser

EXPOSE 8080


HEALTHCHECK CMD curl --fail http://localhost:8080/health || exit 1

CMD ["python", "app.py"]