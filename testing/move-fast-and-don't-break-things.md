## Move Fast and Don't Break Things

Notes from a talk by Ankit Mehta, Google

https://docs.google.com/presentation/d/15gNk21rjer3xo-b1ZqyQVGebOp_aPvHU3YH7YnOMxtE/edit

Copy stored in DT

From the outside, Google appears to be a fast moving company, but internally,
there's a lot of effort getting software released and fighting delays

Automated API tests best bang for the buck. Easy to writ, stable, reliable
signal

Integration tests can be more difficult to debug and high noise facotr

Too much focus on Automated UI testing

- Push on amber
  - Not "push on green". Need to push and cut faster
  - Daily push to prod
  - Smarter regression testing
  - Just run regression tests of things that changed
  - run test stacks in parallel
- Prevent bugs
  - Much faster to prevent bugs than to go back and fix them
  - 200 total bugs / 5 bugs fixed a day = 40 days
  - 10 total bugs / 2 bugs fixed a day = 5 days
  - deterministic, hermetic tests
    - prevent wild goose chases
    - "test on an airplane without network"
    - prevents flakiness
  - prevent bad code from getting in
- Push testing upstream
  - Grow a culture of testing
- Delineate product releases and features
  - Feature flags, dark launch features
  - easier to turn off feature flag than roll-back release
  - Revert features, don't revert releases
- Productivity first
  - tests must be an asset, not a liability
  - 0 tolerance for flakiness
    - flaky tests are worse than no tests
  - 0 tolerance for slow tests
- Fishfood
  - Like dogfooding, but worse
  - Alpha early and often
- Prioritize releases
  - "grass is greener where you water more"
- Treat regressions as build blockers
- Remember murphy's law
  - Kill switches for features
  - big refactorings behind flags
  - all user visible changes behind experiments
- Balance velocity vs quality
  - some things can't be hurried (security, ACLs, data)
