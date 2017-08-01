FROM alpine:3.5

COPY ./hostname /go/bin/hostname

ENV PATH="/go/bin:$PATH"
WORKDIR /go/bin

ENTRYPOINT ["hostname"]