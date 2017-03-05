FROM ubuntu:16.04

ENV APP_ENV="development"

RUN set -x \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        circus \
        nginx-light \
        python \
        python-pip \
        python-setuptools \
        python-pycurl \
        nano \
        wget \
        curl \
        indent \
    && BUILD_DEPS='curl' \
    && apt-get install -qq --no-install-recommends ${BUILD_DEPS} \

    && DOCKERIZE_VERSION=v0.3.0 \
    && DOCKERIZE_TAR=dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && curl -Lo $DOCKERIZE_TAR --fail https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/$DOCKERIZE_TAR \
    && tar -C /usr/local/bin -xzvf $DOCKERIZE_TAR \

    && apt-get autoremove -y ${BUILD_DEPS} \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY requirements.txt /opt/app/
RUN sed -i -e 's|^git.*$||' /opt/app/requirements.txt \
    && pip install --no-cache-dir -r /opt/app/requirements.txt

COPY etc/ /etc/
COPY test.py /opt/app/

# Add start script
COPY ./config/start_web.sh /
COPY ./config/start_worker.sh /

WORKDIR /opt/app/

RUN python -c 'import compileall, os; compileall.compile_dir(os.curdir, force=1)' > /dev/null
