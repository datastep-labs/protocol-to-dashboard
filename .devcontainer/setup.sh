#!/usr/bin/env bash
# Runs once when the codespace is made: the R packages of Sapling's R engine (Linux binaries from Posit Package
# Manager), the data of the CDISC pilot study, and an AI agent's command line (Claude Code; you sign in with your own
# account, or skip it: every chapter works without AI). Sapling SAP and DataStep Studio for R are installed by the
# editor (devcontainer.json); Sapling puts `sapling` on the PATH of every terminal. Log: ~/.sapling-lab/setup.log.
set -uo pipefail
mkdir -p "$HOME/.sapling-lab"
log="$HOME/.sapling-lab/setup.log"
say() { echo "$(date -u +%H:%M:%S) $*" | tee -a "$log"; }
cd "$(dirname "$0")/.."

codename=$(. /etc/os-release && echo "${VERSION_CODENAME:-noble}")
repo="https://packagemanager.posit.co/cran/__linux__/${codename}/2026-11-15"
say "R: $(R --version | head -1); packages from $repo"

sysreqs="libx11-dev libcurl4-openssl-dev libssl-dev cmake make libuv1-dev libfreetype6-dev zlib1g-dev libjpeg-dev
  libpng-dev libtiff-dev libwebp-dev libicu-dev libfontconfig1-dev libfribidi-dev libharfbuzz-dev libxml2-dev"
if sudo -n apt-get -qq update >>"$log" 2>&1 && sudo -n apt-get -y -qq install $sysreqs >>"$log" 2>&1; then
  say "System libraries: installed"
else
  say "System libraries: apt-get did not finish; see $log"
fi

# Deriv (a dependency of admiral) is archived on CRAN: no snapshot has it, so it comes from the CRAN archive first
Rscript -e "if (!requireNamespace('Deriv', quietly = TRUE)) install.packages('https://cran.r-project.org/src/contrib/Archive/Deriv/Deriv_4.2.0.tar.gz', repos = NULL, type = 'source')" >>"$log" 2>&1 || say "Deriv: the archive install did not finish; see $log"

pkgs='c("admiral","dplyr","tidyr","rlang","jsonlite","haven","cards","cardx","broom","emmeans","parameters","car","mmrm","survival","shiny","bslib","processx","callr","shinytest2","openssl","httpuv","evaluate","yaml","testthat","styler","lintr","pkgload","ps","chromote","survminer")'
ok=1
if Rscript -e "options(repos = c(CRAN = '$repo'), Ncpus = 4); p <- $pkgs; install.packages(setdiff(p, rownames(installed.packages())))" >>"$log" 2>&1; then
  say "R packages: installed"
else
  ok=0; say "R packages: the install did not finish; see $log"
fi
# the packages the image ships (knitr, ...) to the same snapshot: a new xfun with an old knitr does not load
Rscript -e "options(repos = c(CRAN = '$repo'), Ncpus = 4); update.packages(ask = FALSE, checkBuilt = TRUE)" >>"$log" 2>&1 || say "R packages: the update did not finish; see $log"
Rscript -e "p <- $pkgs; m <- p[!vapply(p, requireNamespace, TRUE, quietly = TRUE)]; if (length(m)) { cat('missing:', m, '\n'); quit(status = 1) }" >>"$log" 2>&1 || { ok=0; say "R packages: some are missing; see $log"; }

if bash tools/get-data.sh >>"$log" 2>&1; then say "Data: the CDISC pilot SDTM in data/sdtm"; else ok=0; say "Data: the download did not finish; run bash tools/get-data.sh"; fi

if npm install -g @anthropic-ai/claude-code >>"$log" 2>&1; then say "AI agent: claude (sign in with your own account when you first run it; optional)"; else say "AI agent: not installed (optional)"; fi

if [ "$ok" = 1 ]; then say "Ready. Open START-HERE.md."; else say "The setup did not finish. Open START-HERE.md, stop 1: sapling doctor lists what is missing, with the fix."; fi
exit 0
