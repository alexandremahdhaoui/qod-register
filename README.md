# qod-register

The catalog of adoptable package versions for the qod workspace. The pipeline
is the only writer. Consumers resolve versions from tags it publishes on green
runs.

`hack/seed.sh` files one admission request per package the factory pins. It
never writes an index file. Run `forge-register apply` afterwards to answer the
requests.

`hack/publish-members.sh` publishes every qod member into the internal track
with the newest minted revision as provenance.

Every policy knob lives in `forge-register.yaml`. A consumer can read them and
can never set them.
