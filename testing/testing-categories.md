# Testing Categories

* unit test
* integration test
* end-to-end tests
* smoke tests
* production test
* performance test
* security test

## unit tests

most basic. Should run locally during development

## integration tests

run using a real service \(best\), a development fixture \(okay\), or mocked \(worst\)

## End-to-End test

require all components to be running. Tests full process of action. Downside is there's no clear ownership

## smoke test

Tests after a deploy to quickly check it was successful

## failure tests

verify that a system handles failure correctly, e.g., chaos monkey

## production tests

continuously running tests that verify that production is running correctly. Can be simple checks, or create new tenant, add data, teardown test

## performance test

micro level benchmark. macro-level active performance test

## security test

fuzzing, pen testing, security review

