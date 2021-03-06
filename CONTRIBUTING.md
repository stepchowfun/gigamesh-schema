# Contributing

Thank you for your interest in contributing! You can contribute by filing [issues](https://github.com/stepchowfun/gigamesh-schema/issues) and submitting [pull requests](https://github.com/stepchowfun/gigamesh-schema/pulls). Please observe our [code of conduct](https://github.com/stepchowfun/gigamesh-schema/blob/main/CODE_OF_CONDUCT.md).

If you submit a pull request, please ensure your change passes the [GitHub Actions](https://github.com/stepchowfun/gigamesh-schema/actions) CI checks. This will be apparent from the required status check(s) in the pull request.

## Schema style guide

Here, we make note of a few conventions which are not yet enforced automatically. Please adhere to these conventions when possible, and provide appropriate justification for deviations from this guide. If you notice any style violations which appear unintentional, we invite you to bring them to our attention.

### Comments

**Rule:** Comments should be written in American English.

**Rule:** Comments should always be capitalized unless they start with a code-like expression (see below).

**Rule:** Comments which are sentences should be punctuated appropriately. For example:

```perl
# The following logic implements beta reduction.
```

**Rule:** Comments which are not sentences should not have a trailing period. For example:

```perl
# Already normalized
```

**Rule:** Code-like expressions, such as variable names, should be surrounded by backticks. For example:

```perl
# `source_range` is a half-open interval, closed on the left and open on the right.
```
