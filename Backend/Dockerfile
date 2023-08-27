FROM python:3.11-alpine
WORKDIR /code
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements requirements
RUN pip install -r requirements/requirements.txt
EXPOSE 8080
CMD ["python", "/src/main.py"]

