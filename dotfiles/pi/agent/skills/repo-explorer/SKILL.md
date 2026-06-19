---
name: repo-explorer
description: Explore remote Git repositories safely by shallow-cloning them into a temporary workspace, inspecting structure, and answering questions from the checked-out source. Use when a user provides a GitHub/GitLab/Bitbucket/Gitea/git URL and asks to inspect, summarize, audit, or understand the repository.
allowed-tools: Bash(mkdir -p ~/temp/repo-explorer) Bash(ls -la ~/temp/repo-explorer) Bash (git clone *)
---

Use this skill when the user asks you to explore a remote git repository, understand its structure, summarize its contents, inspect implementation details, or answer questions that require looking at files in the repo.

## Repository Cache Directory

Use `~/temp/repo-explorer` as the local cache directory for repositories being explored.

## Current Cache Directory

```!
mkdir -p ~/temp/repo-explorer
ls -la ~/temp/repo-explorer
```

## Flow

1. Check if the repository is already present in the cache directory.
   - If the repo is already present, use that local clone for exploration.
   - If the repo is not present, clone it with depth 1 and explore it.

   ```bash
   git clone --depth 1 <repo-url> ~/temp/repo-explorer/<repo-name>
   ```

2. Inspect repository metadata, instructions, and documentation before making assumptions.
   Prefer `rg`, `rg --files`, and targeted file reads for exploration.

3. Do not run repository scripts, install dependencies, or execute untrusted code unless the user explicitly asks.
