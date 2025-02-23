# TON Symbolic Analyzer reusable Github Actions

This repository contains reusable workflows that enable the execution of [TON Symbolic Analyzer (TSA)](https://github.com/explyt/ton-bounties) within GitHub Actions. This workflows facilitate the display of TSA results in SARIF format in your GitHub repository.

The findings can be observed in the Security "Code Scanning" tab. Also, they are displayed in the merge request conversation.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/1c390ae5-5078-4355-a9f4-a848695ebf0a" />

<img width="500" alt="image" src="https://github.com/user-attachments/assets/da21e3e1-197e-4ec1-a67c-926ed7a7f0ed" />

##
The [example directory](./examples/) contains some examples from the [TSA repository](https://github.com/explyt/ton-bounties) itself.

##

## Roadmap
-   [x] **Set up project**
-   [x] Implement source mapping for Tact
-   [x] TSA docker containers with patched compilers
-   [x] **Test Sarif uploading**
-   [x] FunC analysis job
-   [x] Tact analysis job
-   [ ] Filter flaws
-   [ ] Disable additional gas consumption
-   [ ] Provide more examples
-   [ ] **Review planned**
-   [ ] Interaction analysis (?)

## Project structure

```
tsa-actions/
├── .github/
│   └── workflows/
│       ├── tsa-general.yml
│       ├── tsa-func-analysis.yml
│       ├── tsa-tact-analysis.yml
│       └── example-workflow.yml     # An example workflow that uses the reusable workflows
├── examples
│   ├── fiftstdlib/
│   ├── stdlib.fc
│   ├── func/loop-cell-overflow.fc
│   └── tact/
|       ├── integer-overflow.tact
|       ├── path-sensitive-division.tact
|       └── tact.config.json
└── README.md
```

## Usage

### General
[tsa-general.yml](./.github/workflows/tsa-general.yml)

**Arguments**
- `args` - the string containing any set of arguments. Passed to the TSA without any changes.

**Usage example**
```yaml
jobs:
  run-java-app:
    permissions:
        security-events: write
        actions: read
        contents: read
    uses: jefremof/tsa-actions/.github/workflows/tsa-general.yml@main
    with:
        args: 'tact -c "./examples/tact/tact.config.json" -p "sample" -i "Divider"'
```

> The `args` line is also used as SARIF report categories to distinguish them from one another. \
> https://github.blog/changelog/2024-05-06-code-scanning-will-stop-combining-runs-from-a-single-upload/

##

### Tact Analysis
[tsa-tact-analysis.yml](./.github/workflows/tsa-tact-analysis.yml)

**Arguments**
- `tact_config` - the path to the Tact config (tact.config.json).
- `project_name` - the name of the Tact project to analyze.
- `contract_name` - the name of the Tact smart contract to analyze.
- `contract_data` (optional) - the serialized contract persistent data.

**Usage example**
```yaml
jobs:
  analyze-divider:
    permissions:
        security-events: write
        actions: read
        contents: read
    uses: jefremof/tsa-actions/.github/workflows/tsa-tact-analysis.yml@main
    with:
        tact_config: './examples/tact/tact.config.json'
        project_name: 'sample'
        contract_name: 'Divider'
```

##

### FunC Analysis
[tsa-func-analysis.yml](./.github/workflows/tsa-func-analysis.yml)

**Arguments**
- `func_source` - the path to the FunC source of the smart contract.
- `fift_stdlib` - the path to the Fift standard library (dir containing Asm.fif, Fift.fif)
- `func_stdlib` - the path to the FunC standard library file (stdlib.fc)
- `contract_data` (optional) - the serialized contract persistent data.

**Usage example**
```yaml
jobs:
  analyze-func-cell-overflow:
    permissions:
        security-events: write
        actions: read
        contents: read
    uses: jefremof/tsa-actions/.github/workflows/tsa-func-analysis.yml@main
    with:
        func_source: './examples/func/loop-cell-overflow.fc'
        fift_stdlib: './examples/fiftstdlib'
        func_stdlib: './examples/stdlib.fc'
```