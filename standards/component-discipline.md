# Component Discipline

Component drift is the #1 AI coding failure mode. These rules are non-negotiable. Violation = rejected PR.

## Rule 1: Never Hand-Roll What the Design System Provides

Before creating ANY component, check:

```
1. Does the design system (MUI, shadcn, Chakra, etc.) have this?
2. Does the codebase already have this component?
3. Is there a pattern in the patterns catalog?
```

If answer is YES to any → use it. Do not create a new one.

## Rule 2: Theme Tokens, Never Raw Values

```tsx
// REJECTED — drift
<div style={{ padding: '16px', color: '#333' }}>

// REJECTED — still drift, just hidden
<div className="p-4 text-gray-700">

// ACCEPTED — design system
<Box sx={{ p: 2, color: 'text.primary' }}>
```

- Colors → `theme.palette.*` or `text.primary` etc.
- Spacing → `theme.spacing()` or design system spacing scale
- Typography → `theme.typography.*` variants
- Breakpoints → `theme.breakpoints.*`

## Rule 3: Layout Components, Not Raw Flexbox

```tsx
// REJECTED
<div style={{ display: 'flex', justifyContent: 'space-between' }}>

// ACCEPTED
<Stack direction="row" justifyContent="space-between">
// or
<Grid container spacing={2}>
```

Use the design system's layout primitives. Never raw CSS flexbox/grid.

## Rule 4: One Source of Truth Per Pattern

If the codebase has a modal pattern, there is ONE canonical modal. If you need a different modal, extend the canonical one. Never create ModalV2 because "the existing one doesn't do X."

## Rule 5: Import From Index, Not Internals

```tsx
// REJECTED
import { Button } from '@/components/ui/Button/Button'

// ACCEPTED
import { Button } from '@/components/ui'
```

## Rule 6: No Inline Styles

Zero inline `style={{}}` objects. Zero. Every style lives in the design system, a CSS module, or a styled component.

## Verification Checklist

Before submitting any frontend code, confirm:
- [ ] Zero hand-rolled components that duplicate design system
- [ ] Zero raw color hex values
- [ ] Zero raw spacing values (px, rem)
- [ ] Zero raw flexbox for page layout
- [ ] Zero inline style objects
- [ ] All imports from index barrels
- [ ] New components follow existing patterns
