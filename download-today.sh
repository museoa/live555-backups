#!/usr/bin/env bash

set -euxo pipefail

REMOTE="http://www.live555.com/liveMedia/public"
CURL_CMDLINE="--fail --silent --show-error --location"

# Create daily dir
DAILY_DIR="daily-$(date --iso)"
mkdir -p ${DAILY_DIR}
cd ${DAILY_DIR}

# Download changelog
LOCAL_CHANGELOG="changelog.txt"
REMOTE_CHANGELOG="${REMOTE}/changelog.txt"

eval curl "${CURL_CMDLINE}" --output "${LOCAL_CHANGELOG}" "${REMOTE_CHANGELOG}"

LATEST_DATE=$(head -n1 "${LOCAL_CHANGELOG}" | sed 's|: *$||' | tr '-' '.')

LOCAL_TARBALL="live.${LATEST_DATE}.tar.gz"
REMOTE_TARBALL="${REMOTE}/live.${LATEST_DATE}.tar.gz"
LOCAL_SHA1="live.${LATEST_DATE}.tar.gz.sha1"
REMOTE_SHA1="${REMOTE}/live555-latest-sha1.txt"

eval curl "${CURL_CMDLINE}" --output "${LOCAL_SHA1}" "${REMOTE_SHA1}"
eval curl "${CURL_CMDLINE}" --output "${LOCAL_TARBALL}" "${REMOTE_TARBALL}"

rhash --check "live.${LATEST_DATE}.tar.gz.sha1"
