#!/bin/sh
set -eu

ROOT="${1:-..}"

cd "$ROOT"
forge-factory sync --config forge-factory.yaml --register-head
cd qod-factory
forge test run factory
