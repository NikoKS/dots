---
name: repo-explorer
description: Explore remote Git repositories safely by shallow-cloning them into a temporary workspace, inspecting structure, and answering questions from the checked-out source. Use when a user provides a GitHub/GitLab/Bitbucket/Gitea/git URL and asks to inspect, summarize, audit, or understand the repository.
allowed-tools: Bash(mkdir -p ~/temp/repo-explorer) Bash(ls -la ~/temp/repo-explorer) Bash(git clone *) Bash(git -C ~/temp/repo-explorer/* pull --ff-only)
---

Use this skill when the user asks you to explore a remote git repository, understand its structure, summarize its contents, inspect implementation details, or answer questions that require looking at files in the repo. Once activated for a repository, keep using the local clone as the primary source for the rest of the task and for later follow-up questions about that repository. Do not stop at the initial clone or a top-level directory listing; return to the checked-out source whenever a claim can be verified or clarified from it.

## Repository Cache Directory

Use `~/temp/repo-explorer` as the local cache directory for repositories being explored.

## Current Cache Directory

```!
mkdir -p ~/temp/repo-explorer
ls -la ~/temp/repo-explorer
```

## Flow

1. Check if the repository is already present in the cache directory.
   - If the repo is already present, update it before exploration with a fast-forward-only pull:

     ```bash
     git -C ~/temp/repo-explorer/<repo-name> pull --ff-only
     ```

     If the pull fails because of local changes, divergence, authentication, or network access, do not reset, overwrite, or delete anything. Report the failure and continue with the existing clone, clearly noting that it may be stale.
   - If the repo is not present, clone it with depth 1 and explore it:

     ```bash
     git clone --depth 1 <repo-url> ~/temp/repo-explorer/<repo-name>
     ```

2. Inspect repository metadata, repository-specific agent instructions, documentation, and the top-level file tree before making assumptions.
   Prefer `rg`, `rg --files`, and targeted file reads for exploration.

3. Continue exploring beyond the overview:
   - Identify the relevant packages, entry points, core symbols, configuration, and tests.
   - Trace important behavior from callers or entry points into its implementation rather than relying only on README text or filenames.
   - Read enough surrounding source to understand context, relationships, and edge cases.
   - Cross-check conclusions against tests, examples, and configuration when available.
   - For every follow-up about the repository, resume exploration in the cached clone and inspect additional relevant files before answering. Treat the clone as active working context until the user clearly changes topics.

4. Base answers on evidence from the checked-out repository. Cite repository-relative file paths and relevant symbols or line ranges where useful. Clearly distinguish verified behavior from inference.

5. Do not run repository scripts, install dependencies, or execute untrusted code unless the user explicitly asks.
