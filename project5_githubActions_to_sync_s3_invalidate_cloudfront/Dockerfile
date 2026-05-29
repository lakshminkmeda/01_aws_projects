FROM python:3.8-alpine

LABEL "com.github.actions.name"="AWS S3 Sync with CloudFront Cache invalidation"
LABEL "com.github.actions.description"="Sync a directory to an AWS S3 bucket and invalidate the CloudFront cache"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

LABEL version="1.0"
LABEL repository="https://github.com/lakshminkmeda/sync-s3-invalidate-cloudfront"
LABEL homepage="https://oncloud9.net"
LABEL maintainer="Lakshmi N K Meda"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION="1.18.210"

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]