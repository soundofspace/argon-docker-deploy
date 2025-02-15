# syntax = docker/dockerfile:latest

FROM debian AS data
ARG BITCOIN_DATA_FOLDER

RUN --mount=type=bind,from=bitcoin-data,source=/,target=/bitcoin \
	mkdir /data && \
	tar cvf - bitcoin/blocks bitcoin/chainstate bitcoin/indexes | split --bytes=5GB - /data/bitcoin.tar.

########################

FROM debian


# Make sure we put everything is separate layers so we dont trigger rate limits
# We abuse wildcard here so it doesn't crash if some files don't exist
COPY --link --from=data /data/bitcoin.tar.aa* /init-data/.
COPY --link --from=data /data/bitcoin.tar.ab* /init-data/.
COPY --link --from=data /data/bitcoin.tar.ac* /init-data/.
COPY --link --from=data /data/bitcoin.tar.ad* /init-data/.
COPY --link --from=data /data/bitcoin.tar.ae* /init-data/.
COPY --link --from=data /data/bitcoin.tar.af* /init-data/.
COPY --link --from=data /data/bitcoin.tar.ag* /init-data/.
COPY --link --from=data /data/bitcoin.tar.ah* /init-data/.
COPY --link --from=data /data/bitcoin.tar.ai* /init-data/.
COPY --link --from=data /data/bitcoin.tar.aj* /init-data/.

COPY <<-EOF copy.sh
	#!/bin/bash

	cd /data

	if [ $(ls -A /data/bitcoin | wc -l) -ne 0 ]; then
		cd -
		echo "Bitcoin directory already has data skipping"
		exit 0
	fi

	cat /init-data/bitcoin.tar.* | tar xvf -
	cd -
EOF
RUN chmod +x copy.sh

CMD [ "./copy.sh" ]