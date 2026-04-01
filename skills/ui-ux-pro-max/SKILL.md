---
name: ui-ux-pro-max
description: "UI/UX design intelligence for web and mobile. Includes 50+ styles, 161 color palettes, 57 font pairings, 161 product types, 99 UX guidelines, and 25 chart types across 10 stacks (React, Next.js, Vue, Svelte, SwiftUI, React Native, Flutter, Tailwind, shadcn/ui, and HTML/CSS). Actions: plan, build, create, design, implement, review, fix, improve, optimize, enhance, refactor, and check UI/UX code."
---

# UI/UX Pro Max - Design Intelligence

Comprehensive design guide for web and mobile applications. Contains 50+ styles, 161 color palettes, 57 font pairings, 161 product types with reasoning rules, 99 UX guidelines, and 25 chart types across 10 technology stacks.

## When to Apply

This Skill should be used when the task involves **UI structure, visual design decisions, interaction patterns, or user experience quality control**.

### Must Use

- Designing new pages (Landing Page, Dashboard, Admin, SaaS, Mobile App)
- Creating or refactoring UI components (buttons, modals, forms, tables, charts, etc.)
- Choosing color schemes, typography systems, spacing standards, or layout systems
- Reviewing UI code for user experience, accessibility, or visual consistency
- Making product-level design decisions (style, information hierarchy, brand expression)

### Skip

- Pure backend logic development
- Only involving API or database design
- Performance optimization unrelated to the interface
- Infrastructure or DevOps work

## Rule Categories by Priority

| Priority | Category | Impact | Key Checks (Must Have) | Anti-Patterns (Avoid) |
|----------|----------|--------|------------------------|------------------------|
| 1 | Accessibility | CRITICAL | Contrast 4.5:1, Alt text, Keyboard nav | Removing focus rings, Icon-only buttons without labels |
| 2 | Touch & Interaction | CRITICAL | Min size 44×44px, 8px+ spacing, Loading feedback | Reliance on hover only, Instant state changes (0ms) |
| 3 | Performance | HIGH | WebP/AVIF, Lazy loading, Reserve space (CLS < 0.1) | Layout thrashing, Cumulative Layout Shift |
| 4 | Style Selection | HIGH | Match product type, Consistency, SVG icons (no emoji) | Mixing flat & skeuomorphic randomly, Emoji as icons |
| 5 | Layout & Responsive | HIGH | Mobile-first breakpoints, Viewport meta, No horizontal scroll | Horizontal scroll, Fixed px container widths, Disable zoom |

## Quick Reference

### 1. Accessibility (CRITICAL)

- `color-contrast` - Minimum 4.5:1 ratio for normal text
- `focus-states` - Visible focus rings on interactive elements (2–4px)
- `alt-text` - Descriptive alt text for meaningful images
- `aria-labels` - aria-label for icon-only buttons
- `keyboard-nav` - Tab order matches visual order
- `form-labels` - Use label with for attribute
- `skip-links` - Skip to main content for keyboard users
- `heading-hierarchy` - Sequential h1→h6, no level skip
- `reduced-motion` - Respect prefers-reduced-motion

### 2. Touch & Interaction (CRITICAL)

- `touch-target-size` - Min 44×44pt (Apple) / 48×48dp (Material)
- `touch-spacing` - Minimum 8px/8dp gap between touch targets
- `hover-vs-tap` - Use click/tap for primary interactions
- `loading-buttons` - Disable button during async operations
- `error-feedback` - Clear error messages near problem
- `cursor-pointer` - Add cursor-pointer to clickable elements (Web)

### 3. Performance (HIGH)

- `image-optimization` - Use WebP/AVIF, responsive images, lazy load
- `image-dimension` - Declare width/height to prevent layout shift
- `font-loading` - Use font-display: swap/optional
- `lazy-loading` - Lazy load non-critical components
- `bundle-splitting` - Split code by route/feature
- `virtualize-lists` - Virtualize lists with 50+ items

### 4. Style Selection (HIGH)

- `style-match` - Match style to product type
- `consistency` - Use same style across all pages
- `no-emoji-icons` - Use SVG icons (Heroicons, Lucide)
- `color-palette-from-product` - Choose palette from product/industry
- `platform-adaptive` - Respect platform idioms (iOS HIG vs Material)
- `dark-mode-pairing` - Design light/dark variants together

### 5. Layout & Responsive (HIGH)

- `viewport-meta` - width=device-width initial-scale=1
- `mobile-first` - Design mobile-first, then scale up
- `breakpoint-consistency` - Use systematic breakpoints (375 / 768 / 1024 / 1440)
- `readable-font-size` - Minimum 16px body text on mobile
- `spacing-scale` - Use 4pt/8px incremental spacing system
- `container-width` - Consistent max-width on desktop (max-w-6xl / 7xl)

### 6. Typography & Color (MEDIUM)

- `line-height` - Use 1.5-1.75 for body text
- `line-length` - Limit to 65-75 characters per line
- `font-pairing` - Match heading/body font personalities
- `contrast-readability` - Darker text on light backgrounds
- `color-semantic` - Define semantic color tokens

### 7. Animation (MEDIUM)

- `duration-timing` - Use 150–300ms for micro-interactions
- `transform-performance` - Use transform/opacity only
- `loading-states` - Show skeleton or progress indicator
- `easing` - Use ease-out for entering, ease-in for exiting
- `motion-meaning` - Every animation must express cause-effect

### 8. Forms & Feedback (MEDIUM)

- `input-labels` - Visible label per input (not placeholder-only)
- `error-placement` - Show error below the related field
- `submit-feedback` - Loading then success/error state on submit
- `required-indicators` - Mark required fields
- `empty-states` - Helpful message when no content
- `inline-validation` - Validate on blur

### 9. Navigation Patterns (HIGH)

- `bottom-nav-limit` - Bottom navigation max 5 items
- `back-behavior` - Back navigation must be predictable
- `deep-linking` - All key screens reachable via URL
- `nav-state-active` - Current location visually highlighted
- `modal-escape` - Modals must offer clear close/dismiss

### 10. Charts & Data (LOW)

- `chart-type` - Match chart type to data type
- `color-guidance` - Use accessible color palettes
- `legend-visible` - Always show legend
- `tooltip-on-interact` - Provide tooltips on hover/tap

## Design Systems Reference

### Popular UI Styles

1. **Minimalism & Swiss Style** - Enterprise apps, dashboards
2. **Neumorphism** - Health/wellness apps
3. **Glassmorphism** - Modern SaaS, financial dashboards
4. **Brutalism** - Design portfolios
5. **Claymorphism** - Educational apps, children's apps
6. **Aurora UI** - Modern SaaS, creative agencies
7. **Dark Mode (OLED)** - Night-mode apps, coding platforms

### Tech Stacks

- React, Next.js, Vue, Nuxt.js
- Svelte, SvelteKit
- SwiftUI (iOS)
- React Native
- Flutter
- Tailwind CSS
- shadcn/ui

### Color Palettes

161 industry-specific color palettes available. Search by product type to get recommended palette.

### Typography

57 curated font pairings with Google Fonts imports available.

## Usage Examples

```
Design a landing page for a beauty spa
→ Use style: Soft UI / Minimalist
→ Color: Calming palette with gold accents
→ Typography: Cormorant Garamond / Montserrat
```

```
Build a dashboard for fintech app
→ Use style: Glassmorphism / Dark Mode
→ Color: Trust-focused blues and greens
→ Typography: Clean sans-serif (Inter / SF Pro)
```

```
Create a mobile app for habit tracking
→ Use style: Neumorphism / Soft gradients
→ Color: Vibrant but accessible
→ Typography: Rounded, friendly fonts
```

## Related Skills

- `banner-design` - Banner and advertising design
- `brand` - Brand identity and guidelines
- `design-system` - Design system creation and management
