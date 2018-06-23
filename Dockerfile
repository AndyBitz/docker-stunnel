FROM alpine

# install stunnel
RUN apk add --no-cache stunnel

# expose stunnel port
EXPOSE 6380

# run stunnel
ENTRYPOINT ["stunnel"]
