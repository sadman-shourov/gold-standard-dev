# Architecture

Architecture drift creates unmaintainable codebases. These rules enforce structural integrity.

## Rule 1: Separation of Concerns

```
src/
├── components/     ← UI components only. No API calls.
│   ├── ui/         ← Primitive components (Button, Input, Card)
│   └── features/   ← Feature components (UserList, Dashboard)
├── hooks/          ← Custom hooks. Every API call is a hook.
├── services/       ← API clients, data fetching logic
├── utils/          ← Pure functions, formatters, helpers
├── types/          ← Shared TypeScript types
├── constants/      ← Shared constants, config
└── pages/          ← Route-level components. Thin — compose features.
```

## Rule 2: Component Depth

- UI components: no business logic, no API calls, no context reads beyond theme
- Feature components: compose UI components, call hooks, handle loading/error
- Pages: route setup, compose feature components, minimal logic

## Rule 3: Data Flow

```
Page → Feature Component → Hook → Service → API
                               ↓
                          UI Component (receives data as props)
```

Never: UI Component → API (skip all layers)
Never: Hook → Hook (nested hooks; compose instead)

## Rule 4: Props, Not Context (For Components)

- UI components: props only. Never read context except theme.
- Feature components: props + hooks. Context for cross-cutting concerns (auth, theme).

## Rule 5: One Export Per File (Non-UI)

```
// REJECTED
export function UserList() { ... }
export function UserCard() { ... }

// ACCEPTED — one per file
// UserList.tsx
export function UserList() { ... }
// UserCard.tsx
export function UserCard() { ... }
```

Exception: UI primitive libraries (Button, Input, Card can be barrel-exported).

## Rule 6: No Circular Dependencies

Circular imports = architectural failure. The dependency graph must be a DAG.

```
components/ui → no deps on internal code
components/features → ui, hooks, types
hooks → services, types
services → types
pages → features, hooks
```

## Verification
- [ ] Correct layer placement (UI vs feature vs page)
- [ ] No API calls in UI components
- [ ] No business logic in UI components
- [ ] One component per file (feature/page level)
- [ ] No circular dependencies
