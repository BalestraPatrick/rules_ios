"""Definitions for handling Bazel repositories used by the Apple rules."""

load(
    "@bazel_tools//tools/build_defs/repo:git.bzl",
    "git_repository",
)
load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)

def _maybe(repo_rule, name, **kwargs):
    """Executes the given repository rule if it hasn't been executed already.

    Args:
      repo_rule: The repository rule to be executed (e.g.,
          `http_archive`.)
      name: The name of the repository to be defined by the rule.
      **kwargs: Additional arguments passed directly to the repository rule.
    """
    if not native.existing_rule(name):
        repo_rule(name = name, **kwargs)

def rules_ios_dependencies():
    """Fetches repositories that are dependencies of the `rules_apple` workspace.
    """
    _maybe(
        git_repository,
        name = "build_bazel_rules_apple",
        commit = "fe8cf69b058c86624ba1786e6024c2a1af1d48e9",
        shallow_since = "1581368998 -0800",
        remote = "https://github.com/bazelbuild/rules_apple.git",
    )

    _maybe(
        git_repository,
        name = "build_bazel_rules_swift",
        commit = "657eda57a097980848dbb3c880b94faeddaa3cd1",
        shallow_since = "1580525034 -0800",
        remote = "https://github.com/bazelbuild/rules_swift.git",
    )

    _maybe(
        git_repository,
        name = "build_bazel_apple_support",
        commit = "501b4afb27745c4813a88ffa28acd901408014e4",
        shallow_since = "1577729628 -0800",
        remote = "https://github.com/bazelbuild/apple_support.git",
    )

    _maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        ],
    )
