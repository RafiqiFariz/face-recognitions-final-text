# Use the official lightweight Python image.
# https://hub.docker.com/_/ptyhon
FROM python:3.11-slim

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./app

RUN apt-get update && apt-get install -y build-essential
RUN apt-get update && apt-get -y install cmake

# Install production dependencies.
RUN pip install -r requirements.txt

# Run the web service on a container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the numbers workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scale
# CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
# EXPOSE 5000
# ENV FLASK_APP=app.py
# ENV FLASK_RUN_PORT=8080
CMD python ./app.py

