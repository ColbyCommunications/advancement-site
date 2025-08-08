#!/bin/bash

# A unique ID to group these two jobs into a single build
export PERCY_PARALLEL_NONCE=$(uuidgen)
export PERCY_PARALLEL_TOTAL=2

# Run the first snapshot script in a separate process
percy exec --parallel --total=$PERCY_PARALLEL_TOTAL --nonce=$PERCY_PARALLEL_NONCE -- node project/site_specific/tests/percy/percy.js &

# Run the second snapshot script in a separate process
percy exec --parallel --total=$PERCY_PARALLEL_TOTAL --nonce=$PERCY_PARALLEL_NONCE -- node project/global/tests/percy/percy.js &

# Wait for both background processes to finish
wait