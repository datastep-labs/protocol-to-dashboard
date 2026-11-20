#!/usr/bin/env bash
# The SDTM data of the CDISC pilot study (cdiscpilot01), from the PhUSE scripts repository
# (https://github.com/phuse-org/phuse-scripts, folder data/sdtm/cdiscpilot01, MIT licence), into data/sdtm/.
# About 100 MB. Run from the lab folder: bash tools/get-data.sh
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p data/sdtm
base="https://raw.githubusercontent.com/phuse-org/phuse-scripts/master/data/sdtm/cdiscpilot01"
for d in dm ae ds ex lb mh qs sv vs cm suppdm suppae suppds; do
  if [ ! -s "data/sdtm/$d.xpt" ]; then curl -sfL --retry 3 -o "data/sdtm/$d.xpt" "$base/$d.xpt"; fi
done
cat > data/sdtm/SOURCE.md <<'MD'
# Source of the data

The SDTM data of the CDISC pilot study (cdiscpilot01), from https://github.com/phuse-org/phuse-scripts, folder
`data/sdtm/cdiscpilot01` (MIT licence). Downloaded by `tools/get-data.sh`, unchanged. Public example data: no real
patient.
MD
echo "DATA PASS: $(ls data/sdtm/*.xpt | wc -l | tr -d ' ') SDTM domains in data/sdtm"
