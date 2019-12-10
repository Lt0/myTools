FROM alpine

COPY brook /usr/bin/
COPY entrypoint /usr/bin/
RUN chmod a+x /usr/bin/brook /usr/bin/entrypoint

ENTRYPOINT [ "/usr/bin/entrypoint" ]
