# TON Symbolic Analyser reusable Github Actions

This repository contains reusable workflows that enable the execution of [TON Symbolic Analyzer (TSA)](https://github.com/explyt/ton-bounties) within GitHub Actions. This workflows facilitate the display of TSA results in SARIF format in your GitHub repository.

The examples in the [examples](./examples/) directory are taken from the TSA repository itself.

## Roadmap
-   [x] **Set up project**
-   [x] Implement source mapping for Tact
-   [ ] TSA docker containers with patched compilers
-   [ ] FunC analysis job
-   [ ] Tact analysis job
-   [ ] Disable additional gas consumption
-   [ ] **Review planned**
-   [ ] Interaction analysis (?)

## Project structure

```
tsa-actions/
├── .github/
│   ├── workflows/
│   │   ├── tsa-general.yml
│   │   ├── tsa-func-analysis.yml
│   │   ├── tsa-tact-analysis.yml
│   │   └── example-workflow.yml     # An example workflow that uses the reusable workflows
├── examples
│   ├── fiftstdlib/
│   ├── stdlib.fc
│   ├── func/loop-cell-overflow.fc
│   └── tact/path-sensitive-division.tact
└── README.md
```

## Usage

### General
[tsa-general.yml](./.github/workflows/tsa-general.yml)

- `args` - the string containing any set of arguments. Passed to the TSA without any changes.

### Tact Analysis
[tsa-tact-analysis.yml](./.github/workflows/tsa-tact-analysis.yml)

### FunC Analysis
[tsa-func-analysis.yml](./.github/workflows/tsa-func-analysis.yml)

- `func_source` - the path to the FunC source of the smart contract.
- `fift_stdlib` - the path to the Fift standard library (dir containing Asm.fif, Fift.fif)
- `func_stdlib` - the path to the FunC standard library file (stdlib.fc)
- `contract_data` (optional) - the serialized contract persistent data.
