FROM python:3-alpine

WORKDIR /opt/app

ADD /service/requirements.txt .
RUN pip install -r ./requirements.txt

ADD /service .
RUN chmod +x *.py

RUN addgroup --gid 2000 service-user \
  && adduser --gecos "" \
  --ingroup service-user \
  --uid 2001 \
  --no-create-home \
  --disabled-password service-user \
  && chown -R service-user:service-user /opt/app
USER service-user

CMD ["/opt/app/service.py"]
