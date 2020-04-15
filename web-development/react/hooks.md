## Cleaning up an effect

Often, effects create resources that need to be cleaned up before the component
leaves the screen, such as a subscription or timer ID. To do this, the function
passed to useEffect may return a clean-up function. For example, to create a
subscription:

```js
useEffect(() => {
  const subscription = props.source.subscribe();
  return () => {
    // Clean up the subscription
    subscription.unsubscribe();
  };
});
```

The clean-up function runs before the component is removed from the UI to
prevent memory leaks. Additionally, if a component renders multiple times (as
they typically do), the previous effect is cleaned up before executing the next
effect. In our example, this means a new subscription is created on every
update. To avoid firing an effect on every update, refer to the next section.

## Only Call Hooks at the Top Level

> **Don’t call Hooks inside loops, conditions, or nested functions.** Instead,
> always use Hooks at the top level of your React function. By following this
> rule, you ensure that Hooks are called in the same order each time a component
> renders. That’s what allows React to correctly preserve the state of Hooks
> between multiple useState and useEffect calls

## Naming conventions

Hooks should use the `use` prefix, eg `useFriendStatus`
