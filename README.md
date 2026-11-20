# From Protocol to Dashboard: the lab

The lab of the book **[From Protocol to Dashboard](https://protocol-to-dashboard.pages.dev/)**: write the statistical
analysis plan of the CDISC pilot study with an AI agent, make the ADaM data and the tables in R, and give management a
dashboard. VS Code in your browser, with nothing to install.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/datastep-labs/protocol-to-dashboard)

The codespace has R 4.4 and the packages, the extensions **Sapling SAP** and **DataStep Studio for R**, Quarto, the
Claude Code command line (you sign in with your own account; optional) and the study's data. Open `START-HERE.md`.

| File | What |
|---|---|
| `protocol/usdm.json` | the protocol of the CDISC pilot study as CDISC USDM, from the [CDISC 360i project](https://github.com/cdisc-org/360i) (MIT licence) |
| `data/sdtm/` | the SDTM data of the study, downloaded at setup by `tools/get-data.sh` from the [PhUSE scripts repository](https://github.com/phuse-org/phuse-scripts) (MIT licence) |
| `.devcontainer/` | the codespace: the image, the extensions, the setup |

On your own computer: install VS Code, the two extensions, R 4.4 and Python 3; download this folder; run
`bash tools/get-data.sh` and `sapling doctor` in a terminal of VS Code.

Public example data: no real patient. © 2026 DataStep Labs. The book's text is not under the licences of the data.
