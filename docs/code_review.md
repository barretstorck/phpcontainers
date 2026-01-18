# Code Review: PHP Containers

## 1. Executive Summary
The project provides a lightweight, modular system for generating custom PHP Docker images. The architecture is simple and effective. Recent updates have addressed security, image size, and CI/CD robustness.

## 2. Architecture & Design
*   **Modularity:** (Good) Extensions are isolated in their own directories.
*   **Tag Generation:** (Improved) Centralized in `bin/generate-tag`. Truncation at 128 chars is still present but handled consistently.
*   **Context Dependency:** (Noted) Extensions like `xdebug` rely on `COPY` from the repo root. This is acceptable for this architecture.

## 3. Code Quality & Best Practices
*   **Build Efficiency:** (Noted) Each extension performs its own `apt-get update`. While redundant, it maintains snippet independence.
*   **Alpine Cleanup:** (Fixed) All `apk` snippets now use virtual build dependencies (`--virtual .build-deps`) and cleanup (`apk del`).
*   **Security:** (Fixed) `composer` extension now uses `COPY --from=composer:latest` instead of unverified `ADD`.

## 4. Documentation
*   **README.md:** (Fixed) Grammatical errors and capitalization inconsistencies corrected.
*   **CONTRIBUTING.md:** (Added) Defines standards for new extension snippets.
*   **.gitignore:** (Improved) Standard system and IDE exclusions added.

## 5. Testing & CI/CD
*   **Verification:** (Fixed) `CICD.yml` now includes a `Verify extensions` step that runs `php -m` or binary checks (`node --version`, etc.) on built images.
*   **Dry Runs:** `bin/builddockerfile` now includes a help message for easier local testing.

## 6. Guidelines for AI Agents
When adding new extensions:
1.  **Cleanup:** Always include cleanup commands in the same `RUN` layer.
2.  **Alpine:** Use `.build-deps` virtual package and `apk del`.
3.  **Debian:** Use `--no-install-recommends` and clean `/var/lib/apt/lists/*`.
4.  **Verification:** Add the extension to the test matrix in `.github/workflows/CICD.yml` to ensure it continues to work.