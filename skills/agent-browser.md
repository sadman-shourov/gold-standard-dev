# Agent Browser Skill

Browser automation CLI for AI agents. Testing, QA, bug hunts, form interaction, screenshots, data extraction.

**Source:** `vercel-labs/agent-browser`
**Install:** `npm i -g agent-browser && agent-browser install`

## When to Use

- Testing web apps
- QA and bug hunts
- Filling forms, clicking buttons
- Taking screenshots
- Scraping data from pages
- Exploratory testing
- Dogfooding
- Automating browser tasks

## Core Features

- Fast native Rust CLI (not Node.js wrapper)
- Chrome/Chromium via CDP (no Playwright/Puppeteer)
- Accessibility-tree snapshots with `@eN` element refs
- Sessions, authentication vault, state persistence
- Video recording
- Observability dashboard on port 4848

## Specialized Skills (load via CLI)

```bash
agent-browser skills get core             # workflows, patterns, troubleshooting
agent-browser skills get dogfood          # exploratory testing / QA / bug hunts
agent-browser skills get electron         # Electron desktop apps
agent-browser skills get slack            # Slack workspace automation
```

## Usage in Gold Standard

- QA agent uses this for all UI testing
- Before every ship, QA runs agent-browser smoke tests
- Screenshots compared against UI/UX spec
- Form validation tested end-to-end
