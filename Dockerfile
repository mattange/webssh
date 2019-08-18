# Pull base image.
FROM python:3.7.3-alpine3.9

#RUN apt-get update \
#    && apt-get install -y --no-install-recommends gcc \
#    && rm -rf /var/lib/apt/lists/* \
#    && pip install cryptography \
#    && apt-get purge -y --auto-remove gcc and-build-dependencies

RUN apk --update add --virtual build-dependencies libffi-dev openssl-dev python-dev py-pip build-base \
  && pip install --upgrade pip

# add current directory code and compile/install
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt \
  && apk del build-dependencies libffi-dev openssl-dev python-dev py-pip build-base

EXPOSE 8888

CMD ["python", "run.py"]
