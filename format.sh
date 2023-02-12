#!/usr/bin/env bash

set -euo pipefail

# Java
# curl -sSLO https://github.com/google/google-java-format/releases/download/v1.15.0/google-java-format-1.15.0-all-deps.jar && chmod a+x google-java-format-1.15.0-all-deps.jar
find -name '*.java' | xargs google-java-format-1.15.0-all-deps.jar --replace

# C++
find -name '*.cpp' -o -name '*.c' -o -name '*.h' | xargs clang-format-14 -i

# Kotlin
# curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.48.0/ktlint && chmod a+x ktlint
ktlint -F "examples/**/*.kt" "sanitizers/**/*.kt" "src/**/*.kt" "tests/**/*.kt" --disabled_rules=package-name

# BUILD files
# go install github.com/bazelbuild/buildtools/buildifier@latest
buildifier -r .

# Licence headers
# go install github.com/google/addlicense@latest
addlicense -c "Code Intelligence GmbH" bazel/ deploy/ docker/ examples/ sanitizers/ src/ tests/ *.bzl
