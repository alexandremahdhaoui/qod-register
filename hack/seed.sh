#!/bin/sh
set -eu

WHO="${1:-seed}"

req() {
    forge-register add --requester "$WHO" --reason "seeded from the workspace factory pins" "$1"
}

req go:github.com/google/go-containerregistry
req go:github.com/modelcontextprotocol/go-sdk
req go:github.com/oapi-codegen/runtime
req go:github.com/spf13/cobra
req go:github.com/stretchr/testify
req go:golang.org/x/crypto
req go:sigs.k8s.io/yaml
req go:github.com/vektra/mockery/v3
req go:github.com/oapi-codegen/oapi-codegen/v2
req go:github.com/golangci/golangci-lint/v2

for crate in anyhow clap flatbuffers lz4_flex mockall reqwest rustls serde serde_json thiserror; do
    req "rust:$crate"
done

echo "seeded. run: forge-register apply"
