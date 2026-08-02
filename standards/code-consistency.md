# Code Consistency

Code drift across files is invisible rot. These rules prevent it.

## Rule 1: Consistent File Structure

Every component file follows the same order:
```
1. Imports (external → internal → types → styles)
2. Types/interfaces
3. Component definition
4. Helper functions (if any, at bottom)
5. Export
```

## Rule 2: Consistent Naming

- Components: PascalCase (`UserProfile.tsx`)
- Hooks: camelCase with `use` prefix (`useUserData.ts`)
- Utilities: camelCase (`formatDate.ts`)
- Types: PascalCase with `Props` suffix when component props (`UserProfileProps`)
- API routes: kebab-case (`/api/user-profile`)

## Rule 3: Consistent Patterns

- State management: one pattern per project. If Redux, all state is Redux. If Context, all state is Context. Never mix.
- Data fetching: one pattern. If React Query, all data fetching is React Query.
- Error handling: one error boundary pattern. Consistent error shapes.
- Loading states: one skeleton/loading pattern.

## Rule 4: No Pattern Mutation Within a File

If the project uses function declarations for components:
```tsx
function UserProfile() { ... }
```
Don't switch to arrow functions in the same file:
```tsx
const UserSettings = () => { ... }
```

## Rule 5: Consistent Import Order

```tsx
// 1. React/Next.js
import { useState } from 'react'
import { useRouter } from 'next/navigation'

// 2. External libraries
import { Box, Typography } from '@mui/material'
import { useQuery } from '@tanstack/react-query'

// 3. Internal modules
import { Button } from '@/components/ui'
import { useAuth } from '@/hooks/useAuth'

// 4. Types
import type { User } from '@/types'

// 5. Styles (if any)
```

## Rule 6: No Dead Code

- No commented-out code blocks.
- No unused imports.
- No unused variables.
- If it was useful, it's in git history. Remove it.

## Verification
- [ ] Consistent file structure across all changed files
- [ ] Consistent naming
- [ ] Consistent patterns (state, data fetching, error handling)
- [ ] No pattern mutation within files
- [ ] Consistent import order
- [ ] No dead code
