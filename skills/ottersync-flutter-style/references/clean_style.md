# test_project Style Summary

Reference source: `/Users/themaoqiu/CodeRepo/Android/test/test_project/lib`

This project is not finished, but its structure and coding habits are already clear enough to use as a style baseline.

## Folder split

Top-level folders under `lib/` are separated by responsibility:

- `main.dart`: app bootstrap, only calls `runApp(getRootWidget())`
- `routes/`: root app construction and route table
- `pages/`: top-level screens, including tabs and standalone pages such as login
- `components/`: reusable UI blocks grouped by feature
- `viewmodels/`: simple data models

The split is shallow. There is no heavy domain layering, service layer, or deep feature module tree yet.

## Page organization

Pages are grouped by feature using PascalCase directories:

- `pages/Main/index.dart`
- `pages/Home/index.dart`
- `pages/Login/index.dart`
- `pages/Category/index.dart`
- `pages/Cart/index.dart`
- `pages/My/index.dart`

This makes the page namespace visually obvious and keeps imports predictable.

Inside the main shell:

- `MainPage` owns bottom navigation
- Tab metadata is kept in a private `_TabItem`
- Child pages are assembled through a helper returning `List<Widget>`

This is simple, explicit composition rather than abstract navigation scaffolding.

## Component organization

Home-specific sections are extracted into `components/Home/`:

- `HomeSlider.dart`
- `HomeCategory.dart`
- `HomeSuggestion.dart`
- `HomeHot.dart`
- `HomeMoreList.dart`

The grouping principle is "belongs to one page/feature" rather than "all buttons together" or "all cards together".

## Code style

The overall style is pragmatic and early-stage:

- Most widgets are `StatefulWidget`, even when state is not strongly used yet
- Widgets are small and directly return UI trees
- UI is assembled inline with standard Flutter widgets
- Helper methods return `List<Widget>` or chunks of layout
- Package imports are used consistently
- Naming is straightforward and sometimes imperfect, for example `Homemorelist`, `_getScrollchildern`, and `BunnerItem`

This means the style values readability and forward flexibility more than polish or strict naming hygiene.

## Visual/layout habits

Common patterns visible in the code:

- Direct use of `Scaffold`, `SafeArea`, `CustomScrollView`, `IndexedStack`
- Frequent inline `Padding`, `SizedBox`, `Container`, `TextStyle`, `EdgeInsets`
- Spacing and layout values are written inline rather than abstracted into tokens
- Chinese UI labels are embedded directly in widgets

The code does not try to hide normal Flutter layout code behind utility layers.

## Routing and GoRouter

The project already uses `go_router`.

Observed pattern:

- All routes are defined centrally in `routes/index.dart`
- A file-scoped `GoRouter` is created
- `getRootWidget()` returns `MaterialApp.router`
- `main.dart` stays minimal and imports only the routes entry
- Routes are given `path` and `name`
- Builders instantiate pages directly

This is a good lightweight convention for small and medium apps:

- entry stays stable
- route ownership is obvious
- pages remain decoupled from bootstrap code

## What not to over-copy

Some details are clearly incidental rather than strict standards:

- Not every widget needs to be `StatefulWidget` if the surrounding ottersync file is already cleaner
- Existing typos should not be repeated intentionally
- Missing `const` usage should not become a rule
- Placeholder pages returning plain `Center(Text(...))` reflect unfinished status, not a target finish level

## Recommended carry-forward rules

Use these as the stable essence of the style:

- Keep folder separation shallow and responsibility-based
- Use `pages/<Feature>/index.dart` for top-level screens
- Group reusable sections under `components/<Feature>/`
- Keep routing centralized
- Prefer explicit widget composition over premature architecture
- Match surrounding file polish level instead of refactoring unrelated code
