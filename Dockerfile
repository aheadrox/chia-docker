FROM python:3

ENV TESTNET="false"

#COPY healthcheck.sh /usr/local/bin
RUN python -m pip install --upgrade pip

RUN git clone https://github.com/Chia-Network/chia-blockchain.git && \
    cd chia-blockchain && \
    git checkout tags/1.2.0 -b 1.2.0 && \
    git submodule update --init --recursive && \
    pip install --extra-index-url https://pypi.chia.net/simple/ miniupnpc==2.2.2 && \
    pip install -e . --extra-index-url https://pypi.chia.net/simple/ && \
    chia init

COPY docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
