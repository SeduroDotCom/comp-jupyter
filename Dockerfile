FROM python:3.9.9-slim

WORKDIR /project

RUN apt update \
    && apt install -y gcc musl-dev \
    && apt install -y libcairo2 gir1.2-pango-1.0 libpango-1.0-0 libcairo-gobject2 \
    && apt clean

COPY requirements/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r /tmp/requirements.txt

COPY ./data /project/data
COPY ./notebooks /project/notebooks

CMD ["jupyter-lab","--ip=0.0.0.0","--no-browser","--allow-root"]