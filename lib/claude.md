# Flutter Implementation Guidelines: FemPulse UI

## 1. Architecture & Theming
- **ThemeData:** Define a `ThemeData.dark()` base.
- **Colors:**
  - `primary`: Color(0xFFA78BFA) // Lavender
  - `background`: Color(0 street 121212) // Near Black
  - `surface`: Color(0xFF1E1E1E) // Card Background
- **Responsiveness:** Use `MediaQuery` or `LayoutBuilder` to ensure the grid/list of cards scales well on different screen sizes.

## 2. Component Strategies
- **Pitch Card:** Create a stateless widget `PitchCard`. Use a `Column` inside a `Container` with `BoxDecoration` (border radius 24).
- **Progress Bar:** Use `ClipRRect` around a `LinearProgressIndicator` to get the rounded edge look.
- **Horizontal Chips:** Use a `SizedBox` with a specific height and a `ListView.separated` with `scrollDirection: Axis.horizontal`.

## 3. Best Practices for Code Generation
- **Clean Code:** Request the use of `Padding` widgets rather than empty `SizedBox` for spacing where appropriate, or vice versa for consistency.
- **Modularization:** Ask Claude to separate the `PitchCard`, `CategoryChips`, and `BottomNavBar` into separate methods or widgets for readability.
- **Icons:** Use `Lucide` or `Material Design Icons` (Heroicons are a close match for this UI).

## 4. Specific Flutter Widgets to Use
- `Stack`: For the video thumbnail overlays (Play button/Tags).
- `Wrap`: For the tech stack chips (Python, AWS) to ensure they flow to the next line if the card is narrow.
- `CustomPaint`: (Optional) if the bottom navigation bar requires a specific concave notch.
