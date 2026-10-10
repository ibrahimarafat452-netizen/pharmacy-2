# Change proposal — Design system and usability track in the project plan

**Feature**: cross-phase (`PROJECT_PLAN.md`), raised during 002-legacy-compat-validation ·
**Created**: 2026-10-11 · **Revised**: 2026-10-11 (owner decisions recorded) · **State**: approved

A material change to the approved plan is presented with all five Article XII items and is not
adopted without explicit owner approval.

**Scope boundary.** This proposal changes `PROJECT_PLAN.md` only. It does not:

- amend the constitution;
- change the technology baseline: C# Windows Forms, .NET Framework 4.8, SQLite (System.Data.SQLite
  2.0.4 with the pinned native library and its restricted APIs), Inno Setup 6.7.3;
- add any dependency, package, bundled font or third-party control;
- change any Phase 1 task, evidence rule, matrix row, check, or the Phase 1 gate
  (`.specify/phase-plans/phase-01-gate.ps1`, exit codes 0/2/1) and its rules for blocked, error and
  dry-run records.

## Owner decisions (confirmed 2026-10-11)

| Decision | Choice |
|----------|--------|
| Digits in the UI, receipts, A4 reports and exports | Western digits `0123456789` only |
| Minimum supported screen resolution | 1024×768 |
| Fonts | Windows system fonts only; no bundled fonts |
| Theme | Light theme only |

## 1. Problem

The owner requires a premium, commercially ready Arabic RTL product. The approved plan states this in
one line (section 2, "Interface") and Article IV requires a professional, consistent, readable
interface, but no phase defines how that is designed, built or verified:

- No phase delivers a design system (colours, typography, spacing, icons, components, states).
- No phase has a screen inventory, wireframes, or visual, layout or usability acceptance criteria;
  the acceptance criteria of Phases 3–10 are functional only.
- Arabic RTL usability is first tested in Phase 11, when rework is most expensive.
- Default WinForms controls look dated; without shared components each screen will drift in
  spacing, fonts and behaviour.

Evidence: `PROJECT_PLAN.md` sections 2 and 3; constitution Article IV; the repository contains no
product UI yet (only Phase 1 test windows, which are never shipped), so the gap can be closed now
without rework.

## 2. Proposed change and alternatives

### Proposed change

Add a design and usability track to the plan, built in-house on standard WinForms controls and
GDI+ drawing, with no new dependencies. Proposed wording (to be inserted only after approval):

**Section 2, "Interface"** — replace with:

> **Interface:** Professional Arabic RTL with a documented design system applied consistently to
> every screen; light theme only; Windows system fonts only; Western digits (0–9) everywhere;
> usable at a minimum screen resolution of 1024×768; fast keyboard-first workflows; clear empty,
> loading, error and success states; and minimal resource usage. Visual quality and usability are
> acceptance criteria, not later polish.

**Phase 2** — add to "Define and review":

> - UI architecture and design system: design tokens (light-theme colour palette, type scale using
>   Windows system fonts, 4/8-pixel spacing grid, borders, focus and status colours), Arabic RTL
>   layout and mirroring rules, Western-digit number, date and EGP formatting, icon style,
>   DPI-scaling strategy, and keyboard conventions (shortcuts, tab order, focus rules).
> - Layout rules for the 1024×768 minimum: usable working area, minimum window and dialog sizes,
>   resizing behaviour, column priorities for tables, and overflow handling (truncation with full
>   text available, wrapping, and scrolling only inside lists and tables).
> - Component inventory: buttons, inputs, search box, data table, form layout, dialogs,
>   notifications, status badges, summary cards, simple charts, and empty/loading/error/success
>   states.
> - Screen inventory and wireframes at 1024×768 for the priority screens: dashboard, point of sale,
>   inventory, product management, purchases, customers and debts, reports, and settings.

and to its acceptance criteria:

> - The design system, layout rules, component inventory, screen inventory and priority wireframes
>   are approved by the owner.

**Phase 3** — add to "Implement":

> - Reusable UI component library implementing the approved design system.
> - Screenshot harness that renders each screen and state at the set window sizes and DPI settings.
> - Automated keyboard-navigation tests using the UI Automation support built into .NET Framework.

and to its acceptance criteria:

> - Every shell, login and settings screen is Arabic RTL, uses only library components, and passes
>   the visual checklist in rendered and inspected screenshots at the screen sizes and scaling
>   settings listed below, including on a Windows 7 row.
> - At 1024×768 every screen and dialog fits the working area with no clipped controls, no
>   overlapping text and no page-level horizontal scrolling.
> - Every shell, login and settings workflow can be completed with the keyboard alone.

**Phases 4–8** — add to each phase's acceptance criteria:

> - Every new screen is Arabic RTL, uses only library components, has rendered and inspected
>   screenshots of all its states (including empty, loading, error and success, with realistic
>   Arabic data and long names), fits the 1024×768 layout rules, passes the visual checklist, and
>   passes its keyboard-path tests.

Phase 5 additionally: "A complete sale, from scan to printed receipt, can be done without the
mouse, at 1024×768." Phase 8 additionally: "The dashboard presents summary cards, status indicators
and charts whose figures reconcile with the reports, and remains readable at 1024×768."

**Phase 11** — replace "Arabic RTL usability testing" with:

> - Arabic RTL usability testing with representative pharmacy staff on the priority workflows,
>   including at 1024×768, with task completion and error observations recorded against
>   owner-approved targets.

**Section 4, Cross-Phase Engineering Rules** — add:

> - A screen is complete only when it is Arabic RTL, uses the design system's reusable components,
>   meets the 1024×768 layout rules, has all its states rendered and inspected, and has a tested
>   keyboard workflow. A screen is never reported as visually verified unless it was actually
>   rendered and inspected; rendering on Windows 10/11 does not verify Windows 7.

### Visual verification sizes

| Screen size | Scaling | Purpose |
|-------------|---------|---------|
| 1024×768 | 100 % | Minimum supported size; every screen and dialog |
| 1366×768 | 100 % | Common low-cost laptop and monitor size |
| 1920×1080 | 100 %, 125 %, 150 % | Common desktop size and DPI scaling |

Each size is checked maximised and, for dialogs, at their default size. At 1024×768 only 100 %
scaling is supported (Windows itself does not recommend higher scaling at that size).

### Alternatives considered

| Alternative | Why not preferred |
|-------------|-------------------|
| Keep the plan; rely on Phase 11 usability testing | Visual and usability defects are found after every screen is built; costly rework. |
| Third-party WinForms UI suite (commercial or open source) | New dependency and licence; Windows 7 and .NET 4.8 support and memory cost must be validated. Can be proposed separately later if the in-house library proves insufficient. |
| Switch to WPF or another UI framework | Changes the Phase 1 baseline; heavier on 2–4 GB machines; would invalidate Phase 1 evidence. |
| **In-house design system on WinForms (proposed)** | No new dependency; stays inside the validated baseline; tokens and components in one place. |

## 3. Windows 7 and 32-bit impact

- GDI+ drawing and owner-drawn standard controls are available on Windows 7 SP1 x86/x64 under
  .NET Framework 4.8; no new runtime is required.
- **Fonts**: only fonts shipped with Windows 7 SP1 may be used (candidates: Segoe UI with Tahoma as
  the Arabic fallback). Arabic glyph coverage and rendering quality must be confirmed on the
  Windows 7 rows, extending the existing UI-01/UI-02 RTL checks; no font is installed by the
  product.
- **Digits**: Windows can substitute Arabic-Indic digits in Arabic text depending on the regional
  "native digits" setting. The design system must force Western digits in controls, GDI+ drawing,
  receipts and A4 reports, and this must be tested with that setting changed on Windows 7 and newer.
- **DPI**: Windows 7 supports only system-wide DPI; per-monitor scaling exists only on Windows 10
  1703 and later. The strategy must be system-DPI-aware and tested at 96, 120 and 144 DPI on
  Windows 7.
- **1024×768**: the usable working area is smaller than the screen (the taskbar takes part of it);
  layouts are designed for that area.
- **Memory**: icons and charts drawn as small vector paths or small embedded images; no large
  bitmaps or animations (Article IV). The Phase 1 low-spec performance targets apply to every
  screen.

## 4. Effects on data, security, performance, maintainability and delivery

- **Data**: none; no schema or data change. Western digits affect display and printing only;
  stored values are unaffected.
- **Security**: none; permissions remain enforced in the service layer (Phase 3). The UI shows why
  an action is unavailable instead of only hiding it.
- **Performance**: custom painting must stay within the approved performance targets, measured on
  the low-spec PC with the existing PF checks.
- **Maintainability**: improved; one token set and component library instead of per-screen
  styling; customer branding (Article VII) can be limited to isolated token overrides.
- **Delivery**: adds design work to Phase 2 and library work to Phase 3; reduces rework in
  Phases 4–11. A single light theme and system fonts keep this effort small.

## 5. Required tests and migration or rollback steps

Before a screen is accepted:

- Rendered screenshots of every state at the verification sizes above, inspected by the agent and
  reviewed by the owner, against the visual checklist (alignment to the spacing grid, consistent
  typography, RTL mirroring, no clipped or overlapping content, overflow handled as specified).
- At 1024×768: no page-level horizontal scrolling; tables keep their priority columns visible.
- Colour contrast of text tokens computed and at least 4.5:1 for body text.
- Western digits shown in every control, receipt and report, including with the Windows
  native-digits setting changed.
- UI Automation keyboard tests: tab order, shortcuts, focus return after a scan or dialog.
- Rendering on at least one Windows 7 row; performance on the low-spec PC.

Migration: none; no product code exists yet. Rollback: revert the `PROJECT_PLAN.md` edits; because
styling lives in one token set, later visual changes do not require screen-by-screen rework.

## Article XII check

| Article XII requirement | Where |
|-------------------------|-------|
| 1. Problem or limitation | Section 1 |
| 2. Proposed change and alternatives | Section 2 |
| 3. Windows 7 and 32-bit implications | Section 3 |
| 4. Effects on data, security, performance, maintainability, delivery | Section 4 |
| 5. Required tests and migration or rollback | Section 5 |
| Not implemented before explicit owner approval | Approved 2026-10-11 before `PROJECT_PLAN.md` was changed |

## Approval

Approved by the project owner (ibrahim arafat) on 2026-10-11: "Approve CP-001". Applied to
`PROJECT_PLAN.md` on 2026-10-11.
