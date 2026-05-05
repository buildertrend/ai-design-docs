---
name: Repos and Figma libraries
description: Katie's three code repos (BTNet, Blueprint, BTMobile) and the three Figma libraries that serve them, with locations and relationships
type: reference
---

## Repos

- **BTNet** (`/Users/katie.calhoun/repo/BTNet`) — full-stack web app; BT-prefixed wrapper components in `Clients.App/src/commonComponents/btWrappers/`
- **Blueprint** (`/Users/katie.calhoun/repo/Blueprint`) — the design system source; publishes `@buildertrend/components` (BDS) and `@buildertrend/design-tokens`.
- **BTMobile** (`/Users/katie.calhoun/repo/BTMobile`) — Mobile app currently **in transition from fully native (iOS Swift / Android Kotlin) to fully React Native**. The app is brownfield: native and RN screens coexist. Some pages encountered may still be native — flag this immediately if found. RN components live under `packages/core/ui/`; native code lives in `ios/` (Swift) and `android/` (Kotlin). Developers work with **BT-prefixed RN components only**, sourced from `packages/core/ui/components/`. Other files in the parent folder (e.g., `ListItemBulletList.tsx`) are not ready-to-use components for direct developer consumption.

  **Standard component wrapping chain** (outermost → innermost) — this is the norm for most components:
  1. **BT-prefixed component** (e.g., `BTButton`, `BTText`) — the layer developers use. BTMobile-specific; distinct from Blueprint's BT-prefixed components.
  2. **Gluestack UI** — RN component library styled via NativeWind/Tailwind. Never used in BTNet or Blueprint.
  3. **RN built-in** — React Native's own primitive components (e.g., `Text`, `View`). These are unstyled by default. Example: `BTText` → Gluestack → RN `Text`.

  **Exceptions to the standard chain** (some components deviate — always read the source to confirm the actual wrapping):
  - **Fully custom (no Gluestack)** — e.g., `BTScrim`: built entirely from scratch, no Gluestack layer.
  - **3rd-party library instead of Gluestack** — e.g., `BTSegmentedControl`: wraps Expo's `SegmentedControl` ([docs](https://docs.expo.dev/versions/latest/sdk/segmented-control/)). Delegates rendering to native iOS UIKit, so most styling is system-controlled and cannot be overridden via tokens.
  - **React Navigation (header/navigation layer)** — React Navigation is a **third-party community library** (`@react-navigation/*`), not part of React Native itself. React Native ships only primitives (View, Text, Pressable, etc.) — the navigation layer is provided by this library. Header and navigation components follow the same BT-prefixed wrapping pattern but live in a separate package: `packages/core/navigation-components/src/`. Key components: `BTHeader`, `BTNavButton`, `BTHeaderBackButton`. `BTHeader` returns `null` — it's a declarative component that calls `navigation.setOptions()` via `useLayoutEffect` to configure the native header bar. Sub-components are slotted into React Navigation's `headerLeft`/`headerRight`. React Navigation passes `tintColor` down to slotted components, which is why `BTHeaderText` and `BTHeaderIcon` have a `color` prop (tintColor forwarding only — do not use these components outside navigation headers). **For component generation:** visual elements provided by React Navigation (e.g., the platform back chevron from `HeaderBackButton`) are platform-native and outside BTMobile's design system — substitute the closest Blueprint Base icon and document the gap.

  **Component package locations** — not all components are in `packages/core/ui/components/`:

  | Package | Path | What lives there | Key 3rd-party libraries |
  | --- | --- | --- | --- |
  | Core UI | `packages/core/ui/components/` | Base UI: BTButton, BTFab, BTText, BTBox, BTScreen, etc. | Gluestack UI, NativeWind |
  | Forms | `packages/core/forms/src/` | Form compound components: BTForm, BTFormControl, BTFormField, custom field wrappers | **react-hook-form** (form state), **zod** (validation schemas), Gluestack UI |
  | Navigation components | `packages/core/navigation-components/src/` | Header/nav: BTHeader, BTNavButton, BTScreenWithLargeTitle, BTFormHeader, BTHeaderBackButton, etc. | **@react-navigation** (header chrome), **react-native-reanimated** (large title animations), react-native-keyboard-controller, react-native-safe-area-context |
  | Webview screens | `packages/features/webview/src/screens/` | Screen-level feature components: BTWebViewScreen, BTWebErrorScreen — not reusable UI | **react-native-webview**, expo-clipboard |

  If a component isn't found in `core/ui/components/`, check `core/forms/` and `core/navigation-components/` next, then search broadly across `packages/`.

  - **Pressable:** Any interactive component needing a touch handler uses RN's built-in `Pressable`. It wraps the component at the outermost layer. `BTButton` is an example.
  - **NativeWind:** Bridges Tailwind and React Native. RN has no CSS — it uses style props. NativeWind converts Tailwind class names into RN StyleSheets so components can use the same token-based class syntax as web.
  - **Layout:** RN has no grid — everything is flex. Default flex direction is **column** (not row like web). Account for this when building RN mockups in Figma.
  - **Color system:** `tailwind-preset.js` defines CSS custom properties that resolve to values from `LightColors.ts` (and `DarkColors.ts`). `LightColors.ts` imports **directly from `@buildertrend/design-tokens/react-native`** (Blueprint's published package) for nearly all colors — primary, secondary, tertiary, error, success, warning, info, outline, background, and all raw palette colors (gray, red, orange, yellow, green, teal, blue, indigo, purple, pink). These are **live-linked and always in sync with Blueprint**. The raw palette tokens ranging from `0`–`950` (e.g. `primary/50`, `primary/100`, etc.) are **intended for BTMobile developers only**, specifically for wrapping Gluestack components. They should not be used as design tokens in Figma components or surfaced as design decisions — semantic tokens are the correct layer for that.
  - **`typography` collection (resolved):** The 12-step typography scale (`typography0`–`typography950`) was **hardcoded** in `LightColors.ts` as pure neutral gray — not linked to Blueprint. Blueprint's gray carries a cool blue-gray cast; they were visibly different. **Decision (2026-04-10):** BTMobile will adopt Blueprint's grays for typography to unify the gray system across platforms. The hardcoded values in `LightColors.ts` will be replaced with live-linked Blueprint values.
  - **Also hardcoded (in `tailwind-preset.js` directly):** `typography.white: #FFFFFF`, `typography.gray: #D4D4D4`, `typography.black: #181718`, `background.light: #FBFBFB`, `background.dark: #181719`.
  - **Token usage in code:** The repo intentionally uses Tailwind token defaults rather than explicitly referencing Blueprint tokens — this reduces overhead and avoids potential future bugs from maintaining extra mappings. When generating Figma components via the skill, use Blueprint tokens rather than Tailwind defaults, and note the gap in the audit.

## Figma Libraries

- **Blueprint Base**: https://www.figma.com/design/DiEXVvMnfR1FNwyypAzMnv/Blueprint-Base — source of all primitive color tokens (`color/gray/*`, `color/blue/*`, `color/teal/*`, etc.) and brand tokens (`color/brand/primary1`, `color/base/background`, etc.). Has a "Global Tokens" collection. Also contains icons. Both Blueprint Production and BTMobile alias color tokens from here.
- **Blueprint Production** (also called BDS library): https://www.figma.com/design/q7nfPjI32lW7g9T4mhr8ul/Blueprint-Production — components for BTNet and Blueprint. Its semantic color tokens map to Blueprint Base's primitive tokens.
- **Mobile Design System (React Native)**: https://www.figma.com/design/IRwit3I589T9ax0fQM9cCj/Mobile-Design-System--React-Native- — mobile tokens + components for BTMobile; color tokens alias directly from Blueprint Base. Semantic color tokens map to Blueprint Production's semantic color tokens.
