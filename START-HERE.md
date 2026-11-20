# Start here

Welcome. This codespace is a computer in the cloud with R, Sapling, DataStep Studio for R and the data of the CDISC
pilot study. You work in VS Code, in your browser. The book: https://protocol-to-dashboard.pages.dev/

## Stop 0: wait for the setup

VS Code asks: *Do you trust the authors of the files in this folder?* This folder is the book's lab: click
**Trust Folder & Continue**. Without it the terminal does not start.

The first time, the setup installs the R packages and downloads the data. The terminal shows the progress and ends with
**Ready. Open START-HERE.md.** This takes a few minutes. Later starts are fast.

## Stop 1: check the setup

Open a terminal (*Terminal*, *New Terminal*) and type:

```sh
sapling doctor
```

Each line says OK or FIX; a FIX line shows the command that repairs it.

## Stop 2: the first draft of the SAP

```sh
sapling new pilot --protocol protocol/usdm.json --sdtm data/sdtm --no-open
cd pilot
sapling round --note "the first draft"
```

The scorecard: the agent score, and your readiness. Chapter 5 of the book explains each line.

## Stop 3: the next thing to do

```sh
sapling next
```

From here, follow the book from chapter 6, or start an AI agent in this folder (`claude`) and ask it to work the loop
of `AGENTS.md` (chapter 6).

## Stop 4: the plan as a page

Open `pilot/sap.qmd`. Sapling shows the plan as a page with forms beside it; the checks run as you type.
