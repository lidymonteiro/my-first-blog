# pull official base image
FROM python:3.8.3-alpine

# create root directory for our project in the container
RUN mkdir /code

# set work directory
WORKDIR /code

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

RUN apk add --no-cache --upgrade bash
    
# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /code
COPY . /code

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]