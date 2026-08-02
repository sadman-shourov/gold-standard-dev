# Page Layout

Page layout drift is the most visible form of inconsistency. Users see it immediately. These rules prevent it.

## Rule 1: One Page Shell

Every page uses the same shell:
```tsx
<PageShell>
  <PageHeader title="..." subtitle="..." actions={...} />
  <PageBody>
    {/* content */}
  </PageBody>
</PageShell>
```

## Rule 2: Consistent Spacing

- Page padding: `theme.spacing(3)` (24px)
- Section gap: `theme.spacing(4)` (32px)
- Card gap in grids: `theme.spacing(3)` (24px)
- Content padding inside cards: `theme.spacing(2)` (16px)

## Rule 3: Consistent Grid

- Page body uses 12-column grid
- Cards are always `xs={12} sm={6} md={4}` or similar consistent breaks
- Never ad-hoc width values

## Rule 4: Consistent Header Height

- Page header: 64px
- Section header: 48px
- Card header: 40px

## Rule 5: Consistent Empty States

Every empty state follows the same pattern:
```
<EmptyState
  icon={<Icon />}
  title="No items yet"
  description="Create your first item to get started."
  action={<Button>Create</Button>}
/>
```

## Rule 6: Consistent Error States

Every error state follows the same pattern:
```
<ErrorState
  message="Something went wrong"
  onRetry={refetch}
/>
```

## Rule 7: Responsive by Default

- Mobile first. Always.
- Hidden content on mobile? Use `display: { xs: 'none', md: 'block' }`.
- Stack on mobile, side-by-side on desktop.
- Touch targets ≥ 44px.

## Verification
- [ ] All pages use the same shell
- [ ] Consistent spacing throughout
- [ ] Grid-based layout, not ad-hoc widths
- [ ] Consistent header heights
- [ ] Empty and error states use canonical components
- [ ] Responsive at 320px, 768px, 1024px, 1440px
