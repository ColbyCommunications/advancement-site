#!/usr/bin/env bash

DEV_HOSTNAME=$(echo $PLATFORM_ROUTES | base64 --decode | jq 'keys[0]' | tr -d \")

if [ "${PLATFORM_BRANCH}" != master ]; then
  echo "Running: wp search-replace 'https://${PRIMARY_DOMAIN}/' '${DEV_HOSTNAME}' --all-tables"
  wp search-replace "https://${PRIMARY_DOMAIN}/" "${DEV_HOSTNAME}" --all-tables

  # Construct the full URL for the test page
  PAGE_URL="${DEV_HOSTNAME}test-page/"

  # Echo the full URL to ensure it looks correct
  echo "Attempting to get post ID for URL: ${PAGE_URL}"

  # Execute the wp command directly to get the post ID.
  # Use the `set -e` command to exit immediately if any command fails.
  # `set -o pipefail` is also a good practice.
  set -eo pipefail

  TEST_PAGE=$(wp post url-to-id "${PAGE_URL}")

  # Check if a post ID was returned
  if [[ -z "$TEST_PAGE" ]]; then
      echo "Error: Could not find a post ID for the URL: ${PAGE_URL}"
      exit 1
  fi

  echo "Found post ID: ${TEST_PAGE}"

  # Publish the page
  echo "Publishing Test Page with ID: ${TEST_PAGE}"
  wp post update "${TEST_PAGE}" --post_status=publish
fi