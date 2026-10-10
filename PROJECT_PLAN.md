# Pharmacy Management System — Implementation Plan

## 1. Project Goal

Build a complete, commercially usable Windows desktop pharmacy management system for pharmacies in Egypt.

The application must work fully offline, support Arabic RTL and EGP, run on Windows 7 SP1 (32-bit and 64-bit) and supported newer Windows versions, and remain lightweight on computers with 2–4 GB RAM.

This is a complete product, not an MVP or demo.

The ratified constitution at `.specify/memory/constitution.md` v1.0.1 is the governing authority.

## 2. Core Requirements

- **Offline operation:** No cloud dependency, external API, online activation, telemetry, or internet requirement for installation, licensing, daily operation, reports, or recovery.
- **Compatibility:** Validate Windows 7 SP1 x86/x64 compatibility before committing to the final technology stack.
- **Interface:** Professional Arabic RTL with a documented design system applied consistently to every screen; light theme only; Windows system fonts only; Western digits (0–9) everywhere; usable at a minimum screen resolution of 1024×768; fast keyboard-first workflows; clear empty, loading, error and success states; and minimal resource usage. Visual quality and usability are acceptance criteria, not later polish.
- **Point of sale:** Barcode scanning, fast product lookup, pack/strip sales, configurable conversions, multiple barcodes where required, suspended sales, returns, and receipt reprinting without duplicate transactions.
- **Products and inventory:** Simple product entry, medicine catalog, batch-level expiry tracking, stocktaking, low-stock monitoring, near-expiry alerts, and stagnant-stock reporting.
- **Purchasing and balances:** Suppliers, purchases, supplier balances, customer debts, partial payments, and account statements.
- **Cash management:** Shifts, opening and closing balances, expenses, cash movements, reconciliation, and audit history.
- **Reports:** Sales, gross profit, estimated net profit, inventory, expiry, debts, expenses, and cash-flow reports with clearly defined calculations.
- **Local recommendations:** Explainable stock-replenishment suggestions based on available sales history, current stock, incoming orders, supplier lead time, safety stock, and expiry risks. No cloud AI or clinical recommendations.
- **Security:** User accounts, roles, permissions, and auditing of sensitive operations.
- **Recovery:** Automatic and manual backups, multiple backup generations, integrity checks, and safe restoration.
- **Licensing:** Offline licensing that restricts unauthorized copying while providing a documented recovery process and never holding pharmacy data hostage.
- **Catalog:** Bundle a verified initial Egyptian medicine/product catalog. Do not fabricate barcodes, pack sizes, conversions, or prices. Verify data sources and commercial redistribution rights.
- **Printing:** Support common 80mm thermal receipt printers and A4 reports.
- **Deployment:** Self-contained offline installation with validated dependencies.
- **Product variants:** Maintain a clean core repository and separate, documented customer-specific versions without leaking customizations between customers.

## 3. Implementation Phases

## Phase 0: Requirements Review and Risk Closure

Goal: Resolve ambiguities before expensive implementation.

Deliverables:
- Reviewed requirements and explicit non-goals.
- Prioritized functional requirements and acceptance criteria.
- Risk register and unresolved decisions.
- Constitution compliance checklist.

Acceptance criteria:
- No critical business rule remains ambiguous.
- The owner approves the scope and high-impact decisions.

## Phase 1: Legacy Compatibility and Technology Validation

Goal: Prove that the proposed technology can deliver the required offline Windows application.

Evaluate the proposed baseline:
- C# Windows Forms.
- .NET Framework 4.8.
- SQLite.
- An offline installer containing all required dependencies.

Validate on actual or representative Windows 7 SP1 x86/x64 environments:
- Runtime and database-provider compatibility.
- Application startup and database access.
- Arabic RTL rendering.
- USB HID barcode scanning.
- 80mm receipt printing and A4 reporting.
- Installation, upgrades, and uninstallation without internet.
- Memory usage on a low-spec machine.

Acceptance criteria:
- A documented compatibility decision backed by reproducible tests.
- Any necessary technology change is explained, compared against alternatives, and approved by the owner before implementation proceeds.

Deferral: under change proposal CP-002 (approved 2026-10-11), the owner deferred Phase 1 validation while Phases 2–10 proceed. Phase 1 remains NOT ACCEPTED and the technology baseline remains provisional until the unchanged Phase 1 gate returns exit 0; Windows 7 compatibility is unverified until then. No pilot deployment, customer installation or production release may occur before then; installers built before then are for internal testing only.

## Phase 2: Architecture and Data Integrity Foundation

Goal: Establish a reliable foundation before implementing business workflows.

Define and review:
- Application architecture and module boundaries.
- Database entities, relationships, constraints, and migration strategy.
- Money, quantities, pack/strip conversions, and rounding rules.
- Transaction boundaries and concurrency safeguards.
- Audit logging and permission enforcement.
- Date/time handling and financial calculation definitions.
- Automated test strategy and error handling.
- UI architecture and design system: design tokens (light-theme colour palette, type scale using Windows system fonts, 4/8-pixel spacing grid, borders, focus and status colours), Arabic RTL layout and mirroring rules, Western-digit number, date and EGP formatting, icon style, DPI-scaling strategy, and keyboard conventions (shortcuts, tab order, focus rules).
- Layout rules for the 1024×768 minimum: usable working area, minimum window and dialog sizes, resizing behaviour, column priorities for tables, and overflow handling (truncation with full text available, wrapping, and scrolling only inside lists and tables).
- Component inventory: buttons, inputs, search box, data table, form layout, dialogs, notifications, status badges, summary cards, simple charts, and empty/loading/error/success states.
- Screen inventory and wireframes at 1024×768 for the priority screens: dashboard, point of sale, inventory, product management, purchases, customers and debts, reports, and settings.

Acceptance criteria:
- Architecture and database design are approved.
- Critical invariants have automated tests.
- Database migrations and recovery procedures are documented.
- The design system, layout rules, component inventory, screen inventory and priority wireframes are approved by the owner.

## Phase 3: Application Shell, Users, and Configuration

Goal: Deliver the Arabic RTL application shell with secure user sessions, role-based permissions enforced in the service layer, and offline local configuration that later workflows build on.

Implement:
- Arabic RTL application shell and navigation.
- User login and session handling.
- Manager, Pharmacist, and Cashier roles.
- Permission-controlled sensitive actions.
- Pharmacy identity, receipt settings, printer settings, and local configuration.
- Reusable UI component library implementing the approved design system.
- Screenshot harness that renders each screen and state at the set window sizes and DPI settings (1024×768 and 1366×768 at 100 %; 1920×1080 at 100 %, 125 % and 150 %).
- Automated keyboard-navigation tests using the UI Automation support built into .NET Framework.

Acceptance criteria:
- Unauthorized actions are blocked at the application/service level, not merely hidden in the interface.
- Configuration survives restart and requires no internet.
- Every shell, login and settings screen is Arabic RTL, uses only library components, and passes the visual checklist in rendered and inspected screenshots at the set screen sizes and scaling settings, including on a Windows 7 row.
- At 1024×768 every screen and dialog fits the working area with no clipped controls, no overlapping text and no page-level horizontal scrolling.
- Every shell, login and settings workflow can be completed with the keyboard alone.

## Phase 4: Product Catalog and Inventory

Goal: Enable fast, accurate product management and batch-level inventory with traceable stock movements, validated conversions and expiry handling, and a catalog of documented provenance.

Implement:
- Fast product creation and editing.
- Product search and barcode management.
- Pack/strip units and configurable conversion per product.
- Batch-level quantities, expiry dates, and stock movements.
- Opening stock, stock adjustments, and stocktaking.
- Low-stock, near-expiry, and stagnant-stock monitoring.
- Initial verified Egyptian product catalog.

Acceptance criteria:
- Stock movements are traceable.
- Duplicate barcode conflicts are prevented.
- Conversion and expiry calculations pass boundary tests.
- Catalog provenance and redistribution rights are documented.
- Every new screen is Arabic RTL, uses only library components, has rendered and inspected screenshots of all its states (including empty, loading, error and success, with realistic Arabic data and long names), fits the 1024×768 layout rules, passes the visual checklist, and passes its keyboard-path tests.

## Phase 5: Point of Sale and Returns

Goal: Deliver fast, keyboard-first barcode checkout, returns, and receipt printing in which every sale or return updates stock and financial records atomically and traceably.

Implement:
- Fast barcode-driven checkout.
- Keyboard-first operation and automatic focus management.
- Cash, non-cash, and credit payment recording.
- Suspended and resumed sales.
- Discounts and permission-controlled price changes.
- Sales returns and refund handling.
- Receipt printing and safe reprinting.

Acceptance criteria:
- A sale updates inventory and financial records atomically.
- Failed or interrupted transactions cannot silently corrupt stock or balances.
- Reprinting never creates another sale.
- Returns and refunds are traceable and permission-controlled.
- A complete sale, from scan to printed receipt, can be done without the mouse, at 1024×768.
- Every new screen is Arabic RTL, uses only library components, has rendered and inspected screenshots of all its states (including empty, loading, error and success, with realistic Arabic data and long names), fits the 1024×768 layout rules, passes the visual checklist, and passes its keyboard-path tests.

## Phase 6: Purchases, Suppliers, and Customer Accounts

Goal: Record purchasing, stock receipt, and supplier and customer balances so that every purchase, return, and payment reconciles with inventory and account statements.

Implement:
- Supplier records and purchase transactions.
- Receiving stock and recording expiry batches.
- Supplier balances and payments.
- Customer debts, collections, and partial payments.
- Customer and supplier statements.
- Purchase and payment history.

Acceptance criteria:
- Partial payments and outstanding balances reconcile correctly.
- Purchases, returns, and payments have traceable effects on inventory and accounts.
- Financial transactions cannot be duplicated silently.
- Every new screen is Arabic RTL, uses only library components, has rendered and inspected screenshots of all its states (including empty, loading, error and success, with realistic Arabic data and long names), fits the 1024×768 layout rules, passes the visual checklist, and passes its keyboard-path tests.

## Phase 7: Cash Shifts and Expenses

Goal: Provide auditable cash-shift management in which expected cash is calculated from defined components, discrepancies are visible, and closed shifts cannot be silently changed.

Implement:
- Opening and closing cash shifts.
- Opening cash amount and expected closing balance.
- Cash sales, customer collections, cash refunds, expenses, and other cash movements.
- Non-cash payments and credit sales tracked separately from physical cash.
- Actual counted cash, variance, handover, and shift reports.

Acceptance criteria:
- Expected cash is calculated from explicitly defined components.
- Cash discrepancies are visible and auditable.
- Closed shifts cannot be silently rewritten.
- Every new screen is Arabic RTL, uses only library components, has rendered and inspected screenshots of all its states (including empty, loading, error and success, with realistic Arabic data and long names), fits the 1024×768 layout rules, passes the visual checklist, and passes its keyboard-path tests.

## Phase 8: Reports and Local Stock Recommendations

Goal: Provide decision-oriented reports with documented, reconcilable formulas, and explainable local stock-replenishment suggestions that state their rationale and data limits.

Implement:
- Sales by date, user, product, and payment type.
- Gross profit and estimated net profit after expenses.
- Inventory valuation where valuation rules are defined.
- Customer receivables and supplier payables.
- Expenses, cash flow, and shift reconciliation.
- Low-stock, near-expiry, and stagnant-stock reports.
- Explainable stock-replenishment suggestions.
- CSV export and validated A4 reporting.

Acceptance criteria:
- Every financial metric has a documented formula.
- Credit sales are not treated as collected cash.
- Revenue is not presented as profit.
- Recommendations show their rationale and available data window.
- Insufficient historical data is explicitly handled.
- The dashboard presents summary cards, status indicators and charts whose figures reconcile with the reports, and remains readable at 1024×768.
- Every new screen is Arabic RTL, uses only library components, has rendered and inspected screenshots of all its states (including empty, loading, error and success, with realistic Arabic data and long names), fits the 1024×768 layout rules, passes the visual checklist, and passes its keyboard-path tests.

## Phase 9: Backup, Restoration, and Offline Licensing

Goal: Protect pharmacy data with verified backup and safe restoration, and protect the product with offline licensing that has a documented recovery path and never endangers pharmacy data.

Implement and validate:
- Automatic and manual backups.
- Configurable backup destinations, with preference for a non-system drive.
- Multiple backup generations and safe retention.
- SQLite-consistent backup procedures and integrity verification.
- Restore previews, safeguards, and preservation of the current database before replacement.
- Offline license generation and verification.
- Machine replacement and license recovery procedures.

The private signing key must remain under product-owner control and must not be embedded in the application or distributed repository.

Acceptance criteria:
- Backup and restoration pass documented failure and recovery tests.
- Invalid or incompatible backups cannot silently replace valid data.
- Licensing works offline and has a documented recovery path.
- Licensing failure never deletes or deliberately destroys pharmacy data.

## Phase 10: Customer Variants and Product Packaging

Goal: Package a clean, versioned core product for reproducible offline installation and maintain customer-specific versions without contaminating the core or distributing secrets.

Implement:
- A clean, versioned core product.
- A documented approach for customer-specific repositories or branches.
- Explicit tracking of customizations against the core version.
- Offline installer, bundled dependencies, and configuration.
- Installation, upgrade, rollback, and uninstall procedures.
- User and administrator documentation.

Acceptance criteria:
- A clean installation succeeds without internet.
- A customer-specific build can be reproduced from documented source and configuration.
- Customer changes do not silently contaminate the core product.
- No secrets or private signing keys are distributed.

## Phase 11: System Verification and Pilot Release

Goal: Verify the complete system against all acceptance criteria and target environments, then validate it in a pilot deployment before an owner-approved release.

Perform:
- Unit, integration, and end-to-end testing.
- Financial reconciliation and inventory consistency tests.
- Permission and audit tests.
- Windows compatibility and low-memory tests.
- Barcode, thermal printer, and A4 printer tests.
- Backup/restore, interrupted-operation, and installer failure tests.
- Arabic RTL usability testing with representative pharmacy staff on the priority workflows, including at 1024×768, with task completion and error observations recorded against owner-approved targets.
- Pilot deployment using representative pharmacy workflows.

Acceptance criteria:
- Phase 1 is accepted (Phase 1 gate exit 0) before the pilot deployment begins.
- All critical workflows pass.
- No unresolved critical data-integrity, security, or financial-accuracy defects remain.
- Release checklist, known limitations, recovery instructions, and versioned installer are approved by the owner.

## 4. Cross-Phase Engineering Rules

- Use automated tests for financial calculations, stock movements, conversions, permissions, and database invariants.
- Never use floating-point arithmetic for financial values where exact decimal arithmetic is required.
- Treat stock, cash, debts, and payments as auditable business records.
- Use database transactions for operations that must succeed or fail together.
- Do not introduce cloud services or dependencies that violate offline operation.
- Keep business logic independent of UI code where practical.
- Make consequential technical changes only after explaining the problem, alternatives, compatibility impact, cost, and risk to the owner.
- Do not fabricate catalog data or silently invent business rules.
- Each phase must have measurable acceptance criteria and be reviewed before proceeding.
- A screen is complete only when it is Arabic RTL, uses the design system's reusable components, meets the 1024×768 layout rules, has all its states rendered and inspected, and has a tested keyboard workflow. A screen is never reported as visually verified unless it was actually rendered and inspected; rendering on Windows 10/11 does not verify Windows 7 (change proposal CP-001, approved 2026-10-11).

## 5. Spec-Kit Workflow

After the owner approves this plan:

1. Create a specification for the next approved phase using the repository's existing Spec-Kit workflow.
2. Review the specification for completeness, constitution compliance, acceptance criteria, and unresolved ambiguities.
3. Ask the owner only questions that materially affect correctness, scope, compatibility, or business behavior.
4. Save the approved specification in the correct Spec-Kit location.
5. Generate and review its implementation plan and tasks before coding.
6. Implement only the approved scope and validate it against its acceptance criteria.
7. Proceed to the next phase only after the current phase passes its acceptance gate, except that Phases 2–10 may proceed while Phase 1 validation is deferred under CP-002; that deferral never counts as Phase 1 acceptance and ends no later than the start of Phase 11.

Do not generate all phase specifications at once. Work incrementally to reduce rework and unnecessary token usage.

## 6. Open Decisions to Resolve Before Approval

The planning review must identify and ask about any unresolved decisions that materially affect implementation, including:

- Exact Windows versions and environments available for compatibility testing.
- Final technology stack after Phase 1 validation.
- Catalog source, licensing, update policy, and initial catalog scope.
- Supported payment methods and exact financial/accounting rules.
- Product expiry, returns, negative-stock, and inventory-adjustment policies.
- License recovery rules when a pharmacy computer is replaced or fails.
- Backup retention defaults and restore authorization.
- Minimum printer models and barcode scanner behavior to support.
- Any legal or regulatory requirements applicable to the intended commercial deployment.

Do not assume answers where requirements are not established. Group related questions together and avoid asking about details that can safely be decided during a later specification.

## 7. Plan Approval Rule

This plan is a proposal until reviewed and approved by the project owner. No implementation, code generation, or creation of phase specifications should begin until the owner approves the plan and the next phase is explicitly selected.
