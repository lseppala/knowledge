Testing React hooks is difficult because hooks store state implicitly based on
the component they were invoked in. In order to test hooks, you need to have
some component (or a fake, component-like environment) in which to invoke the
hook.

The package `@testing-library/react-hooks` provides the component-like
environment for testing hooks in isolation

```typescript
import { act, renderHook, cleanup } from "@testing-library/react-hooks";

const { result, waitForNextUpdate } = renderHook(() =>
  useFetch("/test")
);

expect(result.current.someAttr).toBe(...);

// trigger and wait for update of hooks with async functions
await waitForNextUpdate();

expect(result.current.someAttr).toBe(...);
```
