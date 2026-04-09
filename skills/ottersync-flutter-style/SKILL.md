---
name: ottersync-flutter-style
description: Use when adding or modifying Flutter code in ottersync and the work should preserve the existing project style plus the sibling test_project style for folder layout, page/component separation, package imports, entry wiring, and optional GoRouter integration.
---

# Ottersync Flutter Style

Use this skill when working on `/Users/themaoqiu/CodeRepo/Android/ottersync` and the goal is to keep the code aligned with the style established by the sibling reference project at `/Users/themaoqiu/CodeRepo/Android/test/test_project/lib`.

Read [references/test_project_style.md](references/test_project_style.md) before making structural changes, creating new pages, or introducing routing.

## First read

Inspect these files first because they define the current app shell:

- `lib/main.dart`
- `lib/routes/index.dart`
- `lib/pages/Main/index.dart`

If the task is feature-specific, then inspect only the matching page folder and any directly related components.

## Folder rules

Keep the lib directory organized by responsibility, not by technical layer depth:

- `lib/pages/`: top-level screens and tab pages
- `lib/components/`: reusable or page-scoped UI blocks
- `lib/routes/`: app entry wiring and route registration
- `lib/viewmodels/`: lightweight data classes or view models when needed

Follow the reference project's naming pattern:

- A page lives at `lib/pages/<Feature>/index.dart`
- A component group lives at `lib/components/<Feature>/...`
- Directory names are PascalCase
- File names inside feature component groups may also stay PascalCase if that matches nearby code

Do not introduce deep feature nesting unless the current task clearly needs it. This style is intentionally shallow and easy to scan.

## Coding style

Preserve the surrounding file's tone instead of aggressively normalizing it.

Default preferences:

- Use `package:` imports, not relative imports
- Keep widget trees inline and readable
- Prefer small private helper methods such as `_getChildren()` or `_buildSections()` when a widget list gets long
- Use private helper classes for local UI metadata, such as `_TabItem`
- Keep route builders and page containers simple; do not hide basic navigation structure behind extra abstraction
- Use Chinese copy if the surrounding UI already uses Chinese labels

Widget conventions from the reference project:

- Pages are usually `StatefulWidget`
- Extracted UI blocks are often widgets of their own instead of private build methods
- State classes and private helpers use leading underscores
- Naming usually ends with `Page` for full pages and `View` for tab content

Do not "upgrade" older files just for style cleanup. Match the local area you are editing. If the current ottersync file already uses a slightly more polished Material 3 style, keep that level of finish while preserving the same folder split and page organization.

## Routing guidance

The reference project centralizes routing in `lib/routes/index.dart` and exposes a single `getRootWidget()` entry used by `main.dart`.

If the task adds or refactors routing:

- Keep the root app wiring in `lib/routes/index.dart`
- Continue exposing a single `getRootWidget()` function from that file
- Register top-level routes in one place
- Keep page imports explicit and direct

If `go_router` is introduced or expanded:

- Define the router instance at file scope in `lib/routes/index.dart`
- Prefer named routes for top-level pages
- Keep each `GoRoute` builder simple and side-effect free
- Use `MaterialApp.router` from `getRootWidget()`
- Do not spread route registration across multiple files unless the route count becomes large enough to justify it

## When adding new UI

Use this sequence:

1. Decide whether the new code is a page, a page-scoped component, or a simple local widget fragment.
2. Place pages under `lib/pages/<Feature>/index.dart`.
3. If a page starts accumulating repeated sections, move those sections into `lib/components/<Feature>/`.
4. Add lightweight data classes under `lib/viewmodels/` only when the page starts passing structured data around.

## Scope discipline

This style favors momentum over over-engineering.

- Start with a direct implementation
- Extract only the pieces that are visibly reused or make the page easier to read
- Keep business logic light at this stage
- Leave room for later expansion instead of designing for every future case upfront

## References

- Structural and style summary: [references/test_project_style.md](references/test_project_style.md)
