ARG IMAGE_NAME="${IMAGE_NAME:-fedora-toolbox}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-fedora-toolbox}"
ARG SOURCE_ORG="${SOURCE_ORG}"
ARG BASE_IMAGE="registry.fedoraproject.org/${SOURCE_ORG:+$SOURCE_ORG/}${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-42}"
ARG IMAGE_REGISTRY=ghcr.io/azemaviator
ARG BASE_IMAGE_DIGEST=""

FROM scratch AS ctx
COPY /sys_files /sys_files
COPY /build_files /
COPY packages.json /

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}${BASE_IMAGE_DIGEST:+@${BASE_IMAGE_DIGEST}}

ARG IMAGE_NAME="${IMAGE_NAME:-fedora-toolbox}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-42}"
ARG BUILD_NVIDIA="${BUILD_NVIDIA:-N}"

RUN --mount=type=bind,from=ctx,src=/,dst=/ctx \
    --mount=type=cache,target=/var/cache \
    --mount=type=cache,target=/var/log \
    --mount=type=tmpfs,target=/tmp \
    rm -f /usr/bin/chsh && \
    rm -f /usr/bin/lchsh && \
    /ctx/install.sh && \
    if [ "${BUILD_NVIDIA}" == "Y" ]; then \
        /ctx/nvidia-install.sh \
    ; fi && \
    /ctx/post-install.sh
