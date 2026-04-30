# useStore

## Intent
Subscribe React components to external store data with fine-grained reactivity. Built on React's `useSyncExternalStore`, `useStore` allows multiple components to read from the same store and re-render only when the slice of data they care about changes.

## Use when
- Sharing mutable state across components that are not parent/child (i.e., siblings or deeply nested) without prop drilling.
- You need components to subscribe to a store independently so that updates to one store don't re-render unrelated subscribers.
- You need a global context where stores can be added/removed dynamically (use `useSubStore`).

## Avoid when
- Simple local component state is sufficient — use `useState` or `useReducer`.
- The state is already managed by a form library (Formik) or server state library (React Query, SWR).

## Requirements
- A `Context` must wrap the component tree that will subscribe to the store.
- The store must be created with `createStore(initialData, methods?)` and passed as the `value` to a `Context.Provider`.
- Call `useStore(MyContext)` inside any component that should subscribe. The component re-renders only when its subscribed store data changes.

## Recommendations
- Protect store integrity by creating a custom hook that wraps `useStore` and exposes only the methods consumers should call — do not expose the raw `set` method when write access should be controlled.
- Use `useSubStore(BdsGlobalContext, key, createStoreFn)` when the store needs to be globally accessible without manually threading a Context Provider — useful for models that are created and destroyed at runtime (e.g., forms, dialogs).
- Use silent updates (`set(value, true)`) when batching multiple property changes that will trigger a single manual `render()` call later. Only do this when you can guarantee `render()` will be called — otherwise the view goes out of sync.

## Platform notes
- `useSyncExternalStore` is supported natively in React 18. For React 17, a shim is required (included in BDS).

## Accessibility
- No direct accessibility implications. Ensure components that render store data follow standard ARIA and focus management rules.

## Examples

### Single store — basic usage

```tsx
type MyStore = { name: string; count: number };
const MyStoreContext = React.createContext<Stored<MyStore>>({} as Stored<MyStore>);

// Provider (parent component)
const store = createStore<MyStore>({ name: "store", count: 0 });
<MyStoreContext.Provider value={store}>
  <ChildComponent />
</MyStoreContext.Provider>

// Subscriber (child component)
function ChildComponent() {
  const { data, set } = useStore<MyStore>(MyStoreContext);
  return (
    <BuiButton onClick={() => set({ count: data.count + 1 })}>
      Count: {data.count}
    </BuiButton>
  );
}
```

### Multiple stores in one context

```tsx
// Each component subscribes to its own store.
// Updating store1 does not re-render the store2 subscriber.
const { data: store1Data, set: setStore1 } = useStore<MyStore>(MyStoreContext, "store1");
const { data: store2Data, set: setStore2 } = useStore<MyStore>(MyStoreContext, "store2");
```

### Protected store with custom methods

```tsx
type Methods = { add: (delta?: number) => void; subtract: (delta?: number) => void };

const store = createStore<MyStore, Methods>(
  { name: "store", count: 0 },
  {
    add: (ref, set) => (delta = 1) => set({ count: ref.current.count + delta }),
    subtract: (ref, set) => (delta = 1) => set({ count: ref.current.count - delta }),
  }
);

// Consumer hook — only exposes add/subtract, not raw set
function useMyStore() {
  const { data, add, subtract } = useStore<MyStore, Methods>(MyStoreContext);
  return { store: data, add, subtract };
}
```

### Global sub-store (useSubStore)

```tsx
// Works off BdsGlobalContext — no extra Provider needed.
// All components calling useMySubStore share the same underlying store.
function useMySubStore() {
  const key = "myStore";
  const { data, add } = useSubStore<MySubStore, MySubStoreMethods>(
    BdsGlobalContext,
    key,
    createMySubStore
  );
  return { data, add };
}
```

### Store API reference

```ts
type Stored<T, M = {}> = {
  get: () => T;
  set: (v: Partial<T>, silent?: boolean) => void;
  subscribe: (onStoreChange: () => void) => () => void;
  render: () => void;
  getSubscriberCount: () => number;
  hasNonrenderedChanges: () => boolean;
  // ...M — any custom methods defined at createStore time
};
```

## Anti-patterns

- Calling `set(value, true)` (silent update) without a guaranteed later `render()` call — the view will not update.
- Using `useStore` for local component state — use `useState` instead.
- Exposing the raw `set` method from a store that should have controlled writes — wrap in a custom hook with named methods.
- Creating a new `store` inside a component body on every render — create the store outside the component or in a stable ref/context.
