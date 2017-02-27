#!/bin/sh

set -e

err() {
    >&2 echo "==========ERROR==========";
    >&2 echo "$@";
    >&2 echo "==========ERROR==========";
    exit 1;
}

if [ "${CI}" != "drone" ] && [ "${DRONE}" != "true" ]; then
    err "Not a Drone CI environment";
fi

if ! echo "${DRONE_REPO_LINK}" | grep -q 'github.com'; then
    err "Repository is not on GitHub"
fi

if [ -z "${DRONE_PULL_REQUEST}" ]; then
    echo "This is not a pull request"
    exit 0
fi

if [ -z "${GITHUB_TOKEN}" ]; then
    env
    err "GITHUB_TOKEN secret not found!"
fi

if [ "${DRONE_BUILD_STATUS}" = "success" ]; then
    REVIEW_EVENT="APPROVE"
    REVIEW_CONTENT="@${DRONE_COMMIT_AUTHOR} congratulations! ${DRONE_REPO_LINK}/commit/${DRONE_COMMIT_SHA} CI test passed!\nPlease wait for the further review from the maintainers!\n\n For the details, please take a look at ${DRONE_BUILD_LINK}"
else
    REVIEW_EVENT="REQUEST_CHANGES"
    REVIEW_CONTENT="${DRONE_REPO_LINK}/commit/${DRONE_COMMIT_SHA} CI test failed!\n\n@${DRONE_COMMIT_AUTHOR} please take a look at CI build ${DRONE_BUILD_LINK} for details!\n Most of the error will have corresponding explanation, so that you will know what's wrong and then try to fix it!\n If you cannot understand the error message and still need help, feel free to ask help from our maintainers!"
fi

API_URL="https://api.github.com/repos/${DRONE_REPO}/pulls/${DRONE_PULL_REQUEST}/reviews"
REVIEW="{ \"body\": \"${REVIEW_CONTENT}\", \"event\": \"${REVIEW_EVENT}\"}"

curl --silent -H "Accept: application/vnd.github.black-cat-preview+json" -H "Authorization: token ${GITHUB_TOKEN}" -d "${REVIEW}" "${API_URL}" > /dev/null
