FROM alpine as prebuild

# https://android.googlesource.com/platform/tools/base/+/studio-master-dev/source.md
ADD https://storage.googleapis.com/git-repo-downloads/repo /usr/bin/repo
RUN chmod a+x /usr/bin/repo

RUN apk add --no-cache --virtual android-studio-prebuild-dependencies \
    git

RUN apk add --no-cache --virtual android-studio-edge-prebuild-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    openjdk14-jdk \
    openjdk14-doc \
    python3

RUN ln -s /usr/bin/python3 /usr/bin/python

ENV ANDROID_STUDIO_REVISION studio-master-dev

WORKDIR /android-studio
RUN repo init -u https://android.googlesource.com/platform/manifest -b ${ANDROID_STUDIO_REVISION}
RUN repo sync -c

# https://android.googlesource.com/platform/tools/base/+/studio-master-dev/studio.md

