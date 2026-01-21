# Extension Config Migration Implementation Plan

> **For Gemini:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Migrate the PHP extension build system from fragmented Dockerfile snippets to a consolidated shell configuration architecture (`config` files) to improve build speed and maintainability.

**Architecture:** 
- **`bin/builddockerfile` (Refactor):** Update the main build script to aggregate dependencies and commands from sourced config files.
- **`extensions/*/config` (New):** Create configuration files for each extension defining dependencies (`APT_DEPS`, `APK_DEPS`) and build actions (`PHP_EXT_INSTALL`, `PECL_INSTALL`, `DOCKERFILE_CONTENTS`).
- **Migration:** Systematically migrate all 40+ existing extensions to the new format and remove old Dockerfile snippets.

**Tech Stack:** Bash, Docker

---

### Task 1: Create Test Harness

**Files:**
- Create: `tests/migration_test.sh`

**Step 1: Create a test script to verify Dockerfile generation**
This script will act as a regression test. It will generate a Dockerfile using the *old* logic (we'll back it up) and the *new* logic (once implemented) to ensure critical components aren't lost, or simply verify the new output structure contains expected consolidated blocks.

*Note: Since the output format is changing significantly, we can't do a direct diff. We will write a test that checks for the presence of the new consolidated structure.*

```bash
#!/bin/bash
# tests/migration_test.sh

# Temporary verify script
./bin/builddockerfile 8.2-fpm bz2 yaml > test_output.dockerfile

if grep -q "RUN apt-get update" test_output.dockerfile; then
    echo "PASS: Consolidated apt-get update found"
else
    echo "FAIL: Consolidated apt-get update NOT found"
    exit 1
fi

if grep -q "libbz2-dev" test_output.dockerfile && grep -q "libyaml-dev" test_output.dockerfile; then
    echo "PASS: Dependencies found"
else
    echo "FAIL: Dependencies missing"
    exit 1
fi
```

**Step 2: Commit**
```bash
chmod +x tests/migration_test.sh
git add tests/migration_test.sh
git commit -m "test: add migration verification script"
```

---

### Task 2: Implement New Builder Logic

**Files:**
- Modify: `bin/builddockerfile`

**Step 1: Rewrite `bin/builddockerfile`**
Replace the loop-and-cat logic with the new source-and-aggregate logic.

*Key Logic:*
1. Define empty arrays/strings: `ALL_APT`, `ALL_APK`, `ALL_PHP_EXT`, `ALL_PECL`, `ALL_ENABLE`, `ALL_CUSTOM`.
2. Loop requested extensions:
   - Check for `extensions/$EXT/config`.
   - Source it.
   - Append `$APT_DEPS` to `ALL_APT`, etc.
   - If `DOCKERFILE_CONTENTS` (function or var) exists, append to `ALL_CUSTOM`.
3. Generate Dockerfile:
   - Header.
   - Consolidated `apt-get` / `apk add` block (sorted, unique).
   - Consolidated `docker-php-ext-install`.
   - Consolidated `pecl install` & `docker-php-ext-enable`.
   - Dump `ALL_CUSTOM`.

**Step 2: Verify it runs (it will produce empty output for now)**
Run: `./bin/builddockerfile 8.2-fpm`
Expected: A basic Dockerfile header (since no extensions have configs yet).

**Step 3: Commit**
```bash
git add bin/builddockerfile
git commit -m "feat: implement consolidated build logic in builddockerfile"
```

---

### Task 3: Migrate Pilot Extensions (bz2 & yaml)

**Files:**
- Create: `extensions/bz2/config`
- Delete: `extensions/bz2/apt.dockerfile`, `extensions/bz2/apk.dockerfile`, `extensions/bz2/all.dockerfile` (if applicable)
- Create: `extensions/yaml/config`
- Delete: `extensions/yaml/*.dockerfile`

**Step 1: Create `extensions/bz2/config`**
Referencing the old files:
- `apt.dockerfile` had: `libbz2-dev`
- `apk.dockerfile` (check contents via `read_file` if needed, likely `bzip2-dev`)
- `docker-php-ext-install bz2`

```bash
# extensions/bz2/config
APT_DEPS="libbz2-dev"
APK_DEPS="bzip2-dev"
PHP_EXT_INSTALL="bz2"
```

**Step 2: Create `extensions/yaml/config`**
Referencing old files:
- `apt`: `libyaml-dev`
- `pecl install yaml`
- `docker-php-ext-enable yaml`

```bash
# extensions/yaml/config
APT_DEPS="libyaml-dev"
APK_DEPS="yaml-dev"
PECL_INSTALL="yaml"
PHP_EXT_ENABLE="yaml"
```

**Step 3: Delete old files for these two**
```bash
rm extensions/bz2/*.dockerfile
rm extensions/yaml/*.dockerfile
```

**Step 4: Verify with Test Harness**
Run: `./tests/migration_test.sh`
Expected: PASS (Output should now contain the consolidated blocks).

**Step 5: Commit**
```bash
git add extensions/bz2 extensions/yaml
git commit -m "refactor: migrate bz2 and yaml to config format"
```

---

### Task 4: Migrate "Simple" Extensions (Batch 1)

**Files:**
- Modify: `extensions/{bcmath,calendar,dba,exif,gettext,mysqli,opcache,pcntl,shmop,sockets,sysvmsg,sysvsem,sysvshm}/config`
- Delete: Old dockerfiles for above.

**Step 1: Migrate extensions that rely purely on `docker-php-ext-install` with no/few deps.**
(Analyze existing files to confirm deps).
- `bcmath`: No deps. `PHP_EXT_INSTALL="bcmath"`
- `calendar`: No deps. `PHP_EXT_INSTALL="calendar"`
- ... and so on.

**Step 2: Delete old files**

**Step 3: Commit**
```bash
git add extensions/
git commit -m "refactor: migrate simple extensions (batch 1)"
```

---

### Task 5: Migrate "Complex" Extensions (Batch 2)

**Files:**
- Modify: `extensions/{gd,intl,zip,pgsql,soap,xsl,ldap}/config`
- Delete: Old dockerfiles.

**Step 1: Migrate extensions with definite system dependencies.**
Example `gd` often needs `libpng-dev`, etc.
Example `zip` needs `libzip-dev`.

**Step 2: Verify Generation**
Run `./bin/builddockerfile 8.2-fpm gd zip` and inspect output.

**Step 3: Commit**
```bash
git add extensions/
git commit -m "refactor: migrate complex extensions (batch 2)"
```

---

### Task 6: Migrate Special Cases (Batch 3)

**Files:**
- Modify: `extensions/{composer,xdebug,nodejs}/config`
- Delete: Old dockerfiles.

**Step 1: Migrate `composer`**
It likely uses a `COPY` or `curl` command.
Use `DOCKERFILE_CONTENTS` for this.

```bash
# extensions/composer/config
DOCKERFILE_CONTENTS=$(cat <<EOF
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
EOF
)
```

**Step 2: Migrate `xdebug`**
Likely uses `pecl install xdebug`.
Has an `ini` file maybe? If so, `DOCKERFILE_CONTENTS` can handle `COPY` or `RUN echo ...`.

**Step 3: Commit**
```bash
git add extensions/
git commit -m "refactor: migrate special case extensions"
```

---

### Task 7: Cleanup and Final Verification

**Files:**
- Modify: `README.md` (if instructions change, though usage is same).
- Remove: `tests/migration_test.sh`

**Step 1: Run full verification**
Try to build a "mega" container with many extensions.
`make build PHP=8.2-fpm EXTENSIONS="bcmath bz2 gd zip yaml composer"`

**Step 2: Remove test harness**
```bash
rm tests/migration_test.sh
```

**Step 3: Commit**
```bash
git add .
git commit -m "chore: cleanup and final verification"
```
