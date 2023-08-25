FROM alpine:3.18 AS build
RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
    clang \
    clang-dev \
    alpine-sdk \
    dpkg \
    cmake \
    ccache \
    python3 \
    libpq-dev \
    boost-dev

WORKDIR /code
COPY ./project /code

RUN ln -sf /usr/bin/clang /usr/bin/cc \
  && ln -sf /usr/bin/clang++ /usr/bin/c++ \
  && update-alternatives --install /usr/bin/cc cc /usr/bin/clang 10\
  && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 10\
  && update-alternatives --auto cc \
  && update-alternatives --auto c++ \
  && update-alternatives --display cc \
  && update-alternatives --display c++ \
  && ls -l /usr/bin/cc /usr/bin/c++ \
  && cc --version \
  && c++ --version \
  && cmake . \
  && make

FROM alpine:3.18
WORKDIR /code
COPY --from=build /code/cpp-app /code/cpp-app
RUN apk add libstdc++ libpq
CMD ["./cpp-app"]