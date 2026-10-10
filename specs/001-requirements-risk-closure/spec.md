# Feature Specification: Phase 0 — Requirements Review and Risk Closure

**Feature Branch**: `001-requirements-risk-closure` (spec directory only; work stays on `main`)

**Created**: 2026-10-10

**Status**: Approved by the owner on 2026-10-10 — owner decisions D-01 to D-14 (clarify rounds 1
and 2) and possible conflicts C-01 to C-05 (clarify round 3) recorded 2026-10-10; some facts remain
"Owner: unconfirmed" and some details are deferred to later phases (see `risk-register.md`)

**Input**: User description: "Phase 0: Requirements Review and Risk Closure. Goal: Resolve ambiguities before expensive implementation. Deliverables: reviewed requirements and explicit non-goals; prioritized functional requirements and acceptance criteria; risk register and unresolved decisions; constitution compliance checklist. Acceptance criteria: no critical business rule remains ambiguous; the owner approves the scope and high-impact decisions."

**Governing documents**: `.specify/memory/constitution.md` v1.0.1 (ratified 2026-10-10) and
`PROJECT_PLAN.md`. Where this spec and the constitution differ, the constitution wins.

**Companion deliverables** (same directory):

- `risk-register.md` — risks, the open-decision log and decisions deferred to later phases.
- `constitution-checklist.md` — one compliance entry per constitution Article I–XIII.

This phase produces documents only. No application code is written in Phase 0.

## Clarifications

### Session 2026-10-10

- Q: Which items the plan does not mention are non-goals for the first release (D-14)? → A: All
  seven listed items are non-goals; non-medicine goods are sold as ordinary products with no
  special handling (NG-11 to NG-17).
- Q: How is cost of goods sold calculated (D-05a)? → A: By the actual cost of the batch the sold
  stock came from (FR-028).
- Q: May expired batches be sold, and how is the batch chosen at sale time (D-06a, D-06b)? → A:
  Expired batches can never be sold; the earliest-expiring batch is selected automatically
  (FR-056).
- Q: Which payment methods are supported, and are split and partial-credit payments required
  (D-04)? → A: Cash, credit and a configurable list of non-cash methods (for example card, wallet,
  InstaPay); split payments and partial credit are allowed; no payment-terminal integration
  (FR-062).
- Q: Must a customer return have its original sale, and where does returned stock go (D-07b,
  D-07d)? → A: Customer returns require the original sale; returned stock goes back to sellable
  stock (FR-065). The "always" in this answer is refined by the round-2 D-07 answer below.

Round 2 (owner answers, same day):

- Q: Which Windows versions are supported and which test environments exist (D-01)? → A: Windows
  7 SP1 x86/x64 and newer supported Windows versions; the exact list is deferred to the Phase 1
  compatibility matrix with owner approval. No Windows 7 test environment, low-spec PC or known
  customer update level is confirmed (FR-012, FR-012a, FR-012b).
- Q: Does the owner approve the Phase 1 technology candidate (D-02)? → A: C# WinForms, .NET
  Framework 4.8 and SQLite are approved as Phase 1 candidates subject to Phase 1 compatibility
  tests; free, commercially compatible dependencies preferred; any stack change follows Article
  XII (FR-015).
- Q: What catalog source is used (D-03)? → A: No licensed source is confirmed; start with an empty
  catalog, CSV/Excel import and fast manual entry; catalog fields and update policy deferred until
  a source exists (FR-059, FR-059a).
- Q: How are selling price, strip price, tax, discounts and net profit handled (D-05b–f)? → A: One
  selling price per product; strip price derived from pack price and per-product conversion with
  an optional per-product override; prices tax-inclusive with no tax recording; fixed or
  percentage discounts within a per-role maximum (line/invoice scope deferred to Phase 5); net
  profit = gross profit − operating expenses − stock write-offs (FR-027a to FR-027e).
- Q: How do customer debt payments work? → A: Partial payments and multiple installments, each
  recorded with its actual method; original amount, total paid and remaining balance always
  shown; only cash actually received changes cash (FR-074).
- Q: What are the expiry alert window, stagnant-stock definition and expiry precision (D-06c–e)?
  → A: 3 months (configurable); 90 days without sales (configurable); expiry recorded as printed
  (day or month/year); when a month/year expiry counts as expired is deferred to Phase 4
  (FR-056a to FR-056c).
- Q: What are the return window, partial-pack return, refund method, supplier-return and
  damaged-return rules (D-07a/c/e/f, D-07d refinement)? → A: 14-day configurable window; strip
  returns where applicable; refund by cash or debt reduction; supplier returns (including expired
  stock) reduce the supplier balance; returned stock is sellable by default, with a single
  "damaged" option that posts a damage write-off in the same transaction (FR-065a to FR-065e).
- Q: What happens when stock is insufficient for a sale (D-08)? → A: The sale is blocked; no
  override in the initial scope (FR-057).
- Q: What is the stock adjustment and stocktaking policy (D-09)? → A: Pharmacists post routine
  adjustments, Manager approval above a configurable threshold; five predefined reasons (roles and
  reasons replaced in round 3 by C-04 and C-03 below); full and
  partial stocktaking (concurrent-sale method deferred to Phase 2/4); write-offs reported as a
  separate loss line (FR-058a to FR-058d).
- Q: What is the licence model (D-10)? → A: Perpetual offline licence bound to one PC, 30-day
  trial, up to two owner-approved transfers per year with documented recovery; an invalid licence
  never blocks reports, backup or export; offline revocation and sales-when-invalid deferred to
  Phase 9; owner issues recovery licences, response time unconfirmed (FR-094a to FR-094e).
- Q: What are the backup defaults and restore authority (D-11)? → A: Automatic at shift close,
  configurable daily, and manual; keep 7 daily, 4 weekly, 6 monthly; Manager-only restore with
  confirmation; same-disk warning, external storage recommended; no encryption in the initial
  release (FR-047a to FR-047e).
- Q: Which printers and scanners are supported (D-12)? → A: USB keyboard-style scanners sending
  Enter; A4 and common 80mm ESC/POS thermal printers through Windows drivers; untested models not
  guaranteed; no test printer model confirmed; internal barcodes generated without duplicates;
  cash drawer opens via the receipt printer on cash sales where supported (FR-096a to FR-096e).
- Q: Have legal requirements been reviewed (D-13)? → A: No. No legal requirement is assumed;
  commercial release (Phase 11) stays blocked until reviewed (FR-098).

Round 3 (owner answers to the possible conflicts in `risk-register.md` §4, same day):

- Q: When stock goes back to a supplier, should it be recorded only as a supplier-return document,
  or also as a "return to supplier" stock adjustment (C-03)? → A: Only as a supplier-return
  document, which posts the stock movement and reduces the supplier balance in one transaction;
  "return to supplier" is removed from the adjustment reasons, leaving four (FR-058b, FR-065d).
  This replaces "five predefined reasons" in the round-2 D-09 answer.
- Q: Which roles may post stock adjustments (C-04)? → A: All three roles (Manager, Pharmacist,
  Cashier); every Cashier adjustment, and any adjustment above the configurable threshold, needs
  Manager approval (FR-058a). This replaces the round-2 D-09 rule that only Pharmacists post
  routine adjustments.
- Q: When a customer return is marked "damaged", does its write-off need the same Manager approval
  as a manual stock adjustment (C-02)? → A: No; the write-off is part of the return, needs only
  return permission and is audited with the return (FR-065e).
- Q: Is shipping unencrypted backups in the first release consistent with Article VI (C-01)? → A:
  Yes, no conflict; Article VI's data-protection clause is met by the documented backup and
  restore (FR-040 to FR-047); the risk that a copied backup can be read is recorded (R-26) with
  storage guidance (FR-047e).
- Q: Should the near-expiry alert window be one pharmacy-wide setting or also adjustable per
  product (C-05)? → A: One pharmacy-wide setting, default 3 months; no per-product override
  (FR-056a).

## User Scenarios & Testing *(mandatory)*

The "users" of this phase are the project owner (who approves scope and decides open questions)
and the teams that specify and build Phases 1–11 (who rely on a stable requirements baseline).

### User Story 1 - Owner reviews and approves the product scope (Priority: P1)

The owner reads one document that states what the complete first commercial release will do,
what it will explicitly not do, and how each capability will be judged as accepted. The owner
approves it or requests changes.

**Why this priority**: The constitution (Article XII) gives the owner final authority over scope.
No later phase may begin until scope is approved (PROJECT_PLAN.md §7).

**Independent Test**: Give the owner `spec.md`. The owner can state, for any capability in
PROJECT_PLAN.md §2, whether it is in scope, its priority and its acceptance criteria, and can name
every explicit non-goal.

**Acceptance Scenarios**:

1. **Given** the reviewed requirements, **When** the owner compares them with PROJECT_PLAN.md §2
   and the constitution, **Then** every core requirement maps to at least one prioritized
   functional requirement with acceptance criteria.
2. **Given** the non-goals list, **When** the owner reviews it, **Then** each non-goal is traced
   to the constitution or to a recorded owner decision (D-14).
3. **Given** the owner approves, **When** approval is recorded, **Then** the spec status changes
   to "Approved" with the date.

---

### User Story 2 - Owner resolves high-impact open decisions (Priority: P1)

The owner receives a grouped list of open decisions (D-01 to D-14), each with the question, why it
matters and which phases it blocks, and answers them.

**Why this priority**: Unanswered decisions about money, stock, returns, licensing, backups and
legal duties would force implementers to invent business rules, which the project plan forbids.

**Independent Test**: Every open decision in PROJECT_PLAN.md §6 that the constitution does not
already settle appears as exactly one clarification marker in this spec and as one row in the
decision log in `risk-register.md`.

**Acceptance Scenarios**:

1. **Given** the decision list, **When** the owner answers a decision, **Then** its marker in this
   spec is replaced by the recorded answer and its decision-log row is marked resolved with date.
2. **Given** a decision the owner cannot answer yet (for example, legal review pending), **When**
   it is left open, **Then** the phases it blocks are listed and those phases do not start.

---

### User Story 3 - Later phases start from a known risk picture (Priority: P2)

The Phase 1 team (and later teams) read the risk register and know which risks threaten their
acceptance criteria, which are blocking, and what mitigation is planned.

**Why this priority**: Phase 1 cannot pass without a Windows 7 SP1 test environment, which does
not exist yet. Making such blockers visible early avoids wasted work.

**Independent Test**: For each phase 1–11, the risk register lists the risks and open decisions
that affect it; the Windows 7 SP1 environment gap is recorded as blocking Phase 1 acceptance.

**Acceptance Scenarios**:

1. **Given** the risk register, **When** a phase is about to start, **Then** its blocking risks and
   unresolved decisions can be listed from the register alone.

---

### User Story 4 - Every phase can show constitution compliance (Priority: P2)

Reviewers use the constitution checklist to see, for each Article I–XIII, which requirements in
this spec satisfy it, its compliance status and what evidence later phases must produce.

**Why this priority**: The constitution's governance section requires a Constitution Check before
work proceeds.

**Independent Test**: `constitution-checklist.md` contains one entry for each Article I–XIII, each
linked to functional requirements in this spec.

**Acceptance Scenarios**:

1. **Given** the checklist, **When** a reviewer looks up any article, **Then** they find the
   requirement references, the status and the evidence expected and its phase.

---

### Edge Cases

- **The owner rejects part of the scope**: the spec is revised and re-submitted; no later phase
  starts on the rejected part.
- **A decision depends on outside advice** (legal, catalog rights): it stays open, the blocked
  phases are recorded, and unblocked phases may proceed only if the owner agrees.
- **A decision conflicts with the constitution**: the conflict is recorded and resolved by
  constitution amendment or by changing the decision before implementation (Governance).
- **No Windows 7 SP1 environment becomes available**: Phase 1 acceptance cannot pass; the owner
  must decide how to obtain one or whether to amend Article II.
- **Catalog data with redistribution rights cannot be obtained**: the product must not ship
  fabricated data; it ships with an empty catalog, CSV/Excel import and fast manual entry
  (FR-059a).
- **A returned item is damaged or from an expired batch**: it does not become sellable — damaged
  items are written off in the return transaction, expired batches stay blocked (FR-065e).

## Requirements *(mandatory)*

### Phase 0 Deliverable Requirements

- **FR-001**: Phase 0 MUST produce reviewed product requirements that trace every core requirement
  of PROJECT_PLAN.md §2 and every constitution article to prioritized functional requirements.
- **FR-002**: Phase 0 MUST list explicit non-goals, each traced to the constitution or marked for
  owner confirmation.
- **FR-003**: Every functional requirement in the product baseline MUST have acceptance criteria
  that can be checked without knowing how it was built.
- **FR-004**: Every open decision in PROJECT_PLAN.md §6 not settled by the constitution MUST appear
  as its own clarification marker in this spec, grouped by topic, with its blocked phases.
- **FR-005**: Phase 0 MUST produce a risk register with likelihood, impact, mitigation, affected
  phases and status per risk, plus a log of unresolved and deferred decisions.
- **FR-006**: Phase 0 MUST produce a constitution compliance checklist with one entry per
  Article I–XIII.
- **FR-007**: Phase 0 MUST NOT contain fabricated catalog data, legal requirements or business
  rules. Anything not established by the owner, the constitution or the project plan is either a
  clarification marker or a deferred decision with an owning phase.
- **FR-008**: Phase 0 is complete only when no clarification markers remain and the owner's
  approval of scope and high-impact decisions is recorded.

### Priority Scheme for the Product Baseline

The product is a complete commercial release, not an MVP (PROJECT_PLAN.md §1). Priorities order
work and risk attention; they do not make anything optional.

- **P1 — Foundational / integrity-critical**: a defect blocks release (Article XI).
- **P2 — Core operational**: required for the commercial release.
- **P3 — Supporting**: required for the release; lower technical risk, delivered after P1/P2
  foundations exist.

### Product Scope and Non-Goals

**In scope (first commercial release)**: everything in PROJECT_PLAN.md §2 as refined by FR-010 to
FR-098 below.

**Non-goals confirmed by the constitution** (Articles IV, VIII, XIII):

- NG-01: Multi-computer LAN installations; the first release is single-computer only.
- NG-02: Cloud synchronization, cloud storage or cloud backup as a required feature.
- NG-03: Online activation, online license checks or telemetry.
- NG-04: Cloud AI or any internet-dependent intelligence.
- NG-05: Electronic tax-invoice / e-receipt integration.
- NG-06: Selling individual tablets (only packages and strips).
- NG-07: Diagnosing patients, prescribing, or recommending changes to prescribed medicines.
- NG-08: A mandatory manufacturer field for medicines.
- NG-09: Presenting the printed receipt as satisfying Egyptian tax or e-invoicing obligations.
- NG-10: Claiming the licensing is impossible to copy or crack, or claiming Windows 7 is secure.

**Non-goals confirmed by the owner** (D-14, 2026-10-10; items PROJECT_PLAN.md does not mention):

- NG-11: Prescription or patient records.
- NG-12: Insurance-company / contract (تعاقدات) sales, including split patient/insurer payment.
- NG-13: Multi-branch or chain operation.
- NG-14: Home-delivery orders.
- NG-15: Customer loyalty or points.
- NG-16: A user interface language other than Arabic.
- NG-17: Special handling of non-medicine retail goods (cosmetics, baby products, etc.); such
  goods are sold as ordinary products with no special handling.

### Product Functional Requirements

#### A. Platform, Offline Operation and Deployment (P1)

- **FR-010**: The system MUST perform installation, activation, daily operation, reporting, backup
  and restoration with no internet connection (Article I).
- **FR-011**: The system MUST NOT require or send telemetry, cloud services or external APIs; all
  business data MUST be stored on the pharmacy computer (Article I).
- **FR-012**: The system MUST run on Windows 7 SP1 32-bit and 64-bit and on the newer supported
  Windows versions listed in the Phase 1 compatibility matrix, which the owner approves (Article
  II, D-01). Compatibility MUST NOT be claimed for any matrix entry until it has been tested;
  Phase 1 acceptance stays blocked until Windows 7 SP1 x86 and x64 have been tested (R-01).
  Exact list of newer versions/editions: Owner: unconfirmed (R-21). Deferred to Phase 1
  specification: "(a) Which newer versions are officially supported: Windows 8.1, 10, 11 (and
  which editions/architectures)?"
- **FR-012a**: Test environments (D-01b, D-01c): no Windows 7 SP1 test environment is available
  (R-01). Availability of a physical 2–4 GB RAM test PC: Owner: unconfirmed (R-22).
- **FR-012b**: Windows 7 update level on customer machines (D-01d): Owner: unconfirmed (R-23).
  Phase 1 MUST validate the offline installer and every required dependency on both bare SP1 and
  updated SP1.
- **FR-013**: The system MUST remain practical on computers with about 2–4 GB RAM; measurable
  targets are set in Phase 1 from measurements on representative hardware (Article II).
- **FR-014**: The system MUST install, upgrade and uninstall from local media with all
  dependencies included (Article I, Phase 10).
- **FR-015**: Technology choices MUST be validated on the actual target OS versions and
  architectures before the stack is final (Article II, Phase 1).
- **FR-016**: The owner approves C# Windows Forms, .NET Framework 4.8 and SQLite as the Phase 1
  candidate technologies, subject to the Phase 1 compatibility tests (D-02). Dependencies SHOULD
  be free and commercially compatible. Any change of stack MUST follow Article XII (documented
  problem, alternatives, impact and explicit owner approval).

**Acceptance criteria (A)**:

- With every network adapter disabled, a clean installation, activation, a sale, a report, a
  backup and a restore all complete on each OS/architecture in the owner-approved Phase 1
  compatibility matrix, including bare and updated Windows 7 SP1 x86 and x64.
- Monitoring during a full working session shows no outbound network attempts by the product.
- Memory and responsiveness meet the Phase 1 targets on the low-spec reference machine.
- Install, upgrade and uninstall succeed offline on each matrix entry without losing data.

#### B. Data Integrity and Financial Accuracy (P1)

- **FR-020**: Each business transaction (sale, purchase, return, payment, expense, debt movement,
  cash movement, stock adjustment) MUST be saved entirely or not at all (Article III).
- **FR-021**: An interrupted operation (crash, power loss, forced shutdown) MUST NOT leave a
  partial sale, wrong stock deduction or inconsistent balance.
- **FR-022**: Posted financial transactions MUST NOT be edited or deleted in place; corrections
  MUST use traceable reversals or adjustments linked to the original.
- **FR-023**: Every stock movement MUST record its source document, timestamp and responsible
  user.
- **FR-024**: Money MUST be calculated exactly in EGP with documented rounding rules (rules defined
  in Phase 2); floating-point approximation MUST NOT be used for money.
- **FR-025**: The system MUST keep revenue, cost of goods sold, gross profit, operating expenses,
  estimated net profit, cash received and outstanding debts as distinct figures; credit sales
  MUST NOT count as cash received.
- **FR-026**: Submitting the same transaction twice (double click, repeated key, reprint) MUST NOT
  create a duplicate transaction.
- **FR-027**: Financial and accounting rules MUST be defined before Phase 2 design; they are
  FR-027a to FR-027e and FR-028 (D-05).
- **FR-027a**: Each product MUST have one selling price, regardless of batch (D-05b).
- **FR-027b**: The strip price MUST be derived from the package price and the product's
  package-to-strip conversion, unless an optional per-product strip-price override is set
  (D-05c).
- **FR-027c**: Prices MUST be entered and shown tax-inclusive. The system MUST NOT record tax
  separately and MUST NOT provide e-invoicing (D-05d).
- **FR-027d**: A discount MAY be a fixed amount or a percentage; each MUST be limited by a
  configurable maximum per role (D-05e). Deferred to Phase 5 specification, for the
  per-line/per-invoice part only: "(e) Discounts: per line, per invoice or both; percentage,
  amount or both; any maximum per role?"
- **FR-027e**: Estimated net profit MUST equal gross profit minus operating expenses minus
  recorded stock losses (write-offs) for the period (D-05f).
- **FR-028**: Cost of goods sold MUST use the actual cost of the batch the sold stock came from
  (D-05a).

**Acceptance criteria (B)**:

- Forced termination at injected points during sale, purchase, return and payment leaves the
  database either fully before or fully after the transaction in 100% of trials.
- For any period, revenue, cost, gross profit, expenses, cash received and receivables recomputed
  from individual transactions equal the reported figures exactly.
- A correction to a posted transaction leaves the original visible and linked to its reversal.
- Every stock quantity equals the sum of its recorded movements.
- For a sale drawn from batches with different costs, cost of goods sold equals the sum of each
  batch's cost times the quantity taken from it.
- With no override, a strip sells at the package price divided by the conversion (after the
  Phase 2 rounding rule); with an override, it sells at the override price.
- A discount above the user's role maximum is refused at the business-logic level.
- For any period, estimated net profit equals gross profit minus operating expenses minus
  recorded write-offs, each recomputed from transactions.

#### C. Security, Permissions and Accountability (P1)

- **FR-030**: The system MUST provide user accounts with at least the roles Manager, Pharmacist and
  Cashier (Article V). The detailed permission matrix is defined in Phase 3.
- **FR-031**: Discounts, returns, price changes, inventory adjustments, cash corrections, user
  administration and restoration MUST be permission-controlled.
- **FR-032**: Sensitive actions MUST be recorded with user, timestamp, affected record and reason
  where appropriate; ordinary users MUST NOT be able to erase or alter this history.
- **FR-033**: Passwords and authentication secrets MUST NOT be stored in plaintext.
- **FR-034**: Permissions MUST be enforced in the business logic, not only by hiding controls.
- **FR-035**: Closed shifts MUST NOT be silently altered.

**Acceptance criteria (C)**:

- Calling each protected operation as a user without the permission is refused at the business
  logic level and the attempt is recorded, even when the interface control is bypassed.
- Inspection of stored data finds no plaintext password.
- Each sensitive action type produces an audit entry with user, time, record and reason field.

#### D. Backup and Recovery (P1)

- **FR-040**: The system MUST support automatic and manual backups using a database-safe method
  (Article X).
- **FR-041**: Backup destination MUST be configurable; a non-system (non-C) drive is preferred
  where available.
- **FR-042**: The system MUST keep multiple backup generations under a retention policy.
- **FR-043**: Backup failures MUST be reported clearly; a failed backup MUST NOT be reported as
  successful.
- **FR-044**: Backups MUST be verifiable for integrity; an invalid or incompatible backup MUST NOT
  replace valid data.
- **FR-045**: Before restoring, the system MUST preserve the current database or provide a
  verified recovery path, and show a preview of what will be restored.
- **FR-046**: The interface MUST show the status and time of the last successful backup.
- **FR-047**: Backup defaults and restore authority are FR-047a to FR-047e (D-11).
- **FR-047a**: The system MUST back up automatically at each shift close and daily at a
  configurable time, and MUST allow manual backup at any time (D-11a).
- **FR-047b**: The default retention MUST keep 7 daily, 4 weekly and 6 monthly backup copies
  (D-11b).
- **FR-047c**: Only a Manager MAY restore a backup, and restoration MUST require an explicit
  confirmation step (D-11c).
- **FR-047d**: The system MUST warn when the backup destination is on the same physical disk as
  the database and MUST recommend external storage; it MUST NOT require external storage (D-11d).
- **FR-047e**: Backups are not encrypted in the initial release. Encryption MAY be added later
  only together with a safe key-recovery method (D-11e). This is consistent with Article VI, whose
  data-protection clause is met by the documented backup and restore in FR-040 to FR-047 (C-01).
  Because anyone holding a backup file can read it, user documentation MUST advise pharmacies to
  keep backup media physically secure (R-26).

**Acceptance criteria (D)**:

- Disconnecting the destination, filling it, or making it read-only produces a clear failure
  message and no "success" status.
- A corrupted or truncated backup file is rejected by verification and cannot be restored.
- After a restore, the pre-restore database is still recoverable.
- A restored database passes all integrity and reconciliation checks from section B.
- Closing a shift creates a backup; a Pharmacist or Cashier attempting a restore is refused; a
  Manager restore does not start without confirmation.
- After simulated backups over 7 months, exactly 7 daily, 4 weekly and 6 monthly copies remain.
- A destination on the database's physical disk produces a warning but is accepted.

#### E. Products, Catalog and Inventory (P2)

- **FR-050**: Users MUST be able to create a product quickly with no manufacturer field; the name
  MAY include strength, concentration or dosage form (Article IV).
- **FR-051**: Each product MUST support package and strip units with a conversion configured per
  product; the system MUST NOT assume one conversion for all products.
- **FR-052**: A product MUST support more than one barcode where required; the same barcode MUST
  NOT be assigned to two different products.
- **FR-053**: Stock MUST be tracked per batch with its expiry date and quantity.
- **FR-054**: The system MUST support opening stock, stock adjustments and stocktaking with
  reasons and audit.
- **FR-055**: The system MUST monitor low stock, raise proactive near-expiry alerts and report
  near-expiry and stagnant stock (Article IX).
- **FR-056**: An expired batch MUST NOT be sold, by any role and with no override (D-06a). At
  sale time the system MUST select the batch automatically, taking stock from the earliest-expiring
  batch first (D-06b).
- **FR-056a**: The near-expiry alert window MUST default to 3 months before expiry and MUST be
  configurable as one pharmacy-wide setting; there is no per-product override (D-06c, C-05).
- **FR-056b**: Stock MUST count as stagnant after 90 days without sales by default; the period
  MUST be configurable (D-06d).
- **FR-056c**: Expiry MUST be recorded as shown on the package, either as a full date or as
  month/year only (D-06e). Deferred to Phase 4 specification, for month/year-only expiry: "(e) Is
  expiry tracked to the day, or to month/year as printed on many packs (this also fixes when a
  batch counts as expired)?" — that is, when a month/year-only expiry counts as expired.
- **FR-057**: A sale or other stock-reducing transaction that would make stock negative MUST be
  blocked (D-08). No override exists in the initial scope; any future override MUST require an
  explicit permission and audit logging and a separate owner-approved scope change.
- **FR-058**: Inventory adjustments and stocktaking MUST follow FR-058a to FR-058d (D-09).
- **FR-058a**: Managers, Pharmacists and Cashiers MAY post stock adjustments. Every adjustment
  posted by a Cashier, and any adjustment above a configurable threshold, MUST stay pending without
  changing stock until a Manager approves it; an adjustment posted by a Manager counts as
  Manager-approved (D-09a, C-04).
- **FR-058b**: Every adjustment MUST carry one of these predefined reasons: damage, expiry
  write-off, loss/theft, count correction (D-09b). Returns to suppliers are not adjustments; they
  are recorded only as supplier-return documents (FR-065d, C-03).
- **FR-058c**: The system MUST support full and partial stocktaking, and sales made while a count
  is in progress MUST be reconciled safely so that no movement is lost or counted twice (D-09c).
  Deferred to Phase 2/4 specification, for the reconciliation method only: "(c) Stocktaking: full
  count only, or also partial counts by shelf/category? May sales continue during a count?"
- **FR-058d**: Stock write-offs MUST be reported as a separate loss line, not as an operating
  expense or as cost of goods sold (D-09d).
- **FR-059**: The product MUST ship an initial Egyptian medicine/product catalog only from verified
  sources with documented redistribution rights; barcodes, pack sizes, conversions and prices
  MUST NOT be fabricated (PROJECT_PLAN.md §2). No licensed catalog source and no redistribution
  rights are confirmed: Owner: unconfirmed (R-05; blocks the Phase 4 catalog deliverable and
  Phase 10 packaging).
- **FR-059a**: Until a verified source exists, the product MUST start with an empty catalog and
  MUST provide a simple CSV/Excel import and fast manual product entry (D-03e). Deferred until a
  licensed catalog source exists (Phase 4 specification at the earliest): "(b) Which fields will
  the catalog provide (name, barcode(s), package size, strips per package, price, active
  ingredient, category)? Which may be left blank for the pharmacy to fill? (c) Scope: medicines
  only, or also non-medicine products? Approximate number of items? (d) Update policy: will the
  owner supply catalog updates (for example, price changes) by offline file, how often, and may
  an update overwrite a pharmacy's own edits to price or conversion?"

**Acceptance criteria (E)**:

- Adding a product with only name, unit conversion, price and barcode takes one form and no
  manufacturer entry.
- Assigning an existing barcode to another product is refused with a message naming the product
  that owns it.
- Conversion and expiry calculations pass boundary tests (one strip per package, maximum strips,
  expiry today, expiry on month boundary).
- Near-expiry alerts and the stagnant-stock report list exactly the batches that match the
  configured thresholds.
- Selling from an expired batch is refused for every role; when several batches are in stock, a
  sale takes stock from the earliest-expiring batch first without user selection.
- Catalog provenance and redistribution rights are documented for every bundled record source;
  with no verified source, the product ships with an empty catalog and imports a CSV/Excel file.
- A sale or adjustment that would make any stock negative is refused for every role.
- With default settings, a batch expiring within 3 months raises an alert, and a product with no
  sales for 90 days appears as stagnant; changing either setting changes the result.
- A Cashier adjustment of any size, and a Pharmacist adjustment above the threshold, stays pending
  with stock unchanged until a Manager approves it; every adjustment has one of the four
  predefined reasons.
- Write-offs appear as their own loss line and reduce estimated net profit, not gross profit.

#### F. Point of Sale and Returns (P2)

- **FR-060**: Checkout MUST be barcode-driven and keyboard-first with automatic focus handling;
  a scan MUST identify the product and add it with minimal interaction (Article IV).
- **FR-061**: Sales MUST support packages and strips only, never individual tablets.
- **FR-062**: Sales MUST record each payment by method, with cash, non-cash and credit kept
  separate. Supported methods are cash, credit (customer debt) and a configurable list of non-cash
  methods (for example card, mobile wallet, InstaPay). A sale MAY be paid by more than one method
  (split payment) and MAY leave part of its total on customer credit. Payments are recorded only;
  there is no payment-terminal integration (D-04).
- **FR-063**: Users MUST be able to suspend a sale and resume it later.
- **FR-064**: Discounts and price changes at sale time MUST be permission-controlled and audited
  (rules in FR-027d).
- **FR-065**: Returns MUST be permission-controlled and audited, and their stock and money effects
  MUST be explicit. A customer return MUST be linked to its original sale; a customer return
  without the original sale MUST be refused (D-07b). By default, returned stock MUST go back to
  sellable stock (D-07d, as refined in round 2).
- **FR-065a**: A customer return MUST be refused after a configurable return window, default 14
  days from the original sale (D-07a).
- **FR-065b**: A package MAY be returned as strips where the product's conversion allows it
  (D-07c).
- **FR-065c**: A customer refund MUST be paid in cash or applied as a reduction of the customer's
  debt (D-07e).
- **FR-065d**: The system MUST support returns to suppliers, including expired stock; a supplier
  return MUST reduce the supplier balance (D-07f). A supplier return MUST be recorded only as a
  supplier-return document that posts its stock movement and its supplier-balance change in one
  transaction; it MUST NOT be recorded as a stock adjustment (C-03).
- **FR-065e**: Damaged or expired returned products MUST NOT remain sellable. The return screen
  MUST offer a single "damaged" option that, in the same transaction as the return, posts a
  damage write-off movement with the D-09 reason "damage". Returned stock of an expired batch
  stays blocked from sale by FR-056. The workflow MUST stay simple (D-07d refinement). This
  write-off is part of the return: it requires only the return permission, is audited with the
  return, and is not subject to the adjustment approval rules of FR-058a (C-02).
- **FR-066**: The system MUST print receipts on common 80mm thermal printers; reprinting MUST NOT
  create a new sale, stock movement or financial record.
- **FR-067**: The receipt MUST NOT claim to be a tax invoice or e-receipt (Article XIII).

**Acceptance criteria (F)**:

- A scan of a known barcode adds the correct product and unit to the sale without mouse use.
- A completed sale updates stock and financial records atomically (section B criteria).
- Reprinting a receipt any number of times leaves sales, stock and cash totals unchanged.
- A return is refused for a user without permission and, when allowed, is linked to its sale
  and audited; a customer return with no original sale is refused.
- A returned quantity is added back to sellable stock, except when "damaged" is chosen: then the
  same transaction records the return and a damage write-off, and sellable stock is unchanged;
  this completes without Manager approval for any user who holds the return permission, including
  a Cashier.
- A return after the configured window (default 14 days) is refused.
- A refund is recorded either as cash (changing expected shift cash) or as a reduction of the
  customer's debt (not changing cash).
- A supplier return, including of expired stock, reduces the supplier balance and appears on the supplier statement.
- A supplier return reduces stock exactly once and the supplier balance exactly once, in the same
  transaction; "return to supplier" cannot be chosen as an adjustment reason.
- A sale split across cash, a non-cash method and customer credit records each part under its
  method; only the cash part changes expected shift cash.

#### G. Purchases, Suppliers and Customer Accounts (P2)

- **FR-070**: The system MUST record suppliers, purchases and receipt of stock with batch and
  expiry data.
- **FR-071**: The system MUST track supplier balances and payments, including partial payments.
- **FR-072**: The system MUST track customer debts, collections and partial payments.
- **FR-073**: The system MUST produce customer and supplier account statements and purchase and
  payment history.
- **FR-074**: A customer debt MUST accept partial payments and multiple installments. For each
  debt the system MUST always show the original amount, the total paid and the remaining balance.
  Every payment MUST be recorded against the customer account with its actual payment method, and
  cash balances MUST change only for cash actually received (Article III; owner answer, round 2).

**Acceptance criteria (G)**:

- After any series of purchases, payments and returns, each supplier and customer balance equals
  the sum of its statement lines.
- A purchase increases batch stock by exactly the received quantities with their expiry dates.
- The same payment cannot be posted twice silently.
- A debt paid in three installments by different methods shows original amount, total paid and
  remaining balance correctly after each installment; only the cash installments change expected
  shift cash.

#### H. Cash Shifts and Expenses (P2)

- **FR-080**: The system MUST support opening and closing cash shifts with opening cash, recorded
  cash movements, expected closing cash, counted cash, variance and handover (Article IX).
- **FR-081**: Expected closing cash MUST be computed from explicitly documented components (cash
  sales, cash collections, cash refunds, cash expenses, other cash movements).
- **FR-082**: Non-cash payments and credit sales MUST be tracked separately from physical cash.
- **FR-083**: Operating expense categories MUST be configurable and include rent, salaries,
  utilities, maintenance and other.
- **FR-084**: A closed shift MUST NOT be rewritten; corrections MUST be traceable.

**Acceptance criteria (H)**:

- For a test shift, expected cash equals opening cash plus/minus each documented component, and
  variance equals counted minus expected.
- Credit and non-cash sales do not change expected cash.
- An attempt to edit a closed shift is refused or produces a linked, audited correction.

#### I. Reports (P2)

- **FR-090**: Reports MUST cover sales (by date, user, product, payment type), gross profit,
  estimated net profit, inventory, inventory valuation (once valuation rules are defined), expiry,
  stagnant stock, low stock, receivables, payables, expenses, cash flow and shift reconciliation.
- **FR-091**: Every financial figure MUST have a documented formula and reconcile with underlying
  transactions; revenue MUST NOT be presented as profit.
- **FR-092**: Reports SHOULD offer filters, A4 printing and CSV export.

**Acceptance criteria (I)**: each report's totals match independent recomputation from
transactions for test datasets; each financial report shows or links to its formula.

#### J. Local Purchase Recommendations (P3)

- **FR-093**: Replenishment suggestions MUST be computed locally with deterministic rules, show the
  main factors and data window behind each quantity, flag insufficient history honestly, account
  for expiry risk, remain advisory, and never give clinical advice (Article VIII).

**Acceptance criteria (J)**: identical data always gives identical suggestions; a product with too
little history is labelled as such; every suggestion lists its factors.

#### K. Offline Licensing (P2)

- **FR-094**: Licenses MUST be validated locally without any server; issuance MUST use an
  owner-controlled signing key never embedded in or shipped with the product; license problems
  MUST NEVER delete, encrypt, hide or make pharmacy data unrecoverable; a documented
  computer-replacement and recovery procedure MUST exist (Article VI).
- **FR-094a**: The licence MUST be a perpetual offline licence bound to one PC (D-10a, D-10b).
- **FR-094b**: A 30-day trial MUST be available (D-10e).
- **FR-094c**: Up to two owner-approved licence transfers per year MUST be allowed, following a
  documented recovery process (D-10c). Deferred to Phase 9 specification, for revocation only: "(c) On
  computer replacement or failure: how many transfers are allowed, what proof is required, and
  how is the old license revoked offline?"
- **FR-094d**: A missing, invalid or expired licence or trial MUST NEVER block reports, backup or
  export, and MUST NEVER endanger pharmacy data (D-10d). Deferred to Phase 9 specification, for sales
  only: "(d) What may the user still do when the license is missing, invalid or expired — for
  example, read-only access, reports and backup/export only, a grace period of N days?" — that
  is, whether sales are allowed in that state.
- **FR-094e**: The owner issues recovery licences; the private signing key stays outside the
  application (Article VI). Recovery response time: Owner: unconfirmed; no commitment is set
  (D-10f, R-25).

**Acceptance criteria (K)**: licensing works with no network; with a missing, invalid or expired
licence or trial, reports, backup and export still work and no data is changed or hidden; a
licence works only on the PC it is bound to; a third transfer within one year is refused; no
customer build contains the private key; the recovery procedure is documented and tested.

#### L. Interface, Configuration, Printing and Scanning (P2)

- **FR-095**: The interface MUST be Arabic right-to-left by default, use EGP, avoid heavy
  animations, and explain errors with a recovery action; pharmacy identity, receipt and printer
  settings MUST persist locally (Article IV, Phase 3).
- **FR-096**: The system MUST support the scanners, printers, internal barcodes and cash drawer in FR-096a to FR-096d
  (D-12).
  Only tested models MAY be claimed as supported; untested models MUST NOT be guaranteed.
- **FR-096a**: Scanners: USB keyboard-style barcode scanners that send Enter after each code
  (D-12c).
- **FR-096b**: Printers: A4 printers and common 80mm ESC/POS thermal printers, both through their
  Windows drivers (D-12a, D-12b). Test printer models: Owner: unconfirmed (R-24; blocks Phase 1
  hardware validation).
- **FR-096c**: The system MUST generate internal barcodes for products without one, and a
  generated barcode MUST NEVER duplicate an existing barcode (D-12d, FR-052).
- **FR-096d**: On a cash sale, the system MUST open the cash drawer through the receipt printer
  where the hardware supports it (D-12e).

**Acceptance criteria (L)**: Arabic text renders correctly right-to-left on screen, receipts and A4
reports on every printer model tested in Phase 1; scanning a code followed by Enter adds the item
without manual focus changes; no generated internal barcode equals any existing barcode; a cash
sale opens a supported drawer, and a non-cash sale does not.

#### M. Customer Variants and Releases (P3)

- **FR-097**: The owner MUST keep a clean core product; each customer variant MUST record its core
  release, keep branding and custom code isolated, and never be merged into the core
  automatically; each release MUST identify product version, source revision and variant; no
  production data or private keys may be in source control (Article VII).

**Acceptance criteria (M)**: a customer build can be reproduced from documented source and
configuration; a scan of the repository finds no databases or private keys.

#### N. Legal and Regulatory (blocks commercial release)

- **FR-098**: The product MUST meet the legal and regulatory requirements the owner confirms as
  applicable; this spec does not assume any. Legal review has not been completed: Owner:
  unconfirmed (D-13, R-07). Commercial release (Phase 11) MUST stay blocked until the applicable
  requirements are reviewed. Open topics for that review: record-keeping for controlled or
  scheduled medicines; what a pharmacy receipt must show; personal-data obligations for customer
  debt records; retention period of sales and financial records; end-user licence terms.

### Key Entities

- **Product**: a sellable item; name (may include strength/form), units, conversion, one selling
  price, optional strip-price override, thresholds; no mandatory manufacturer.
- **Barcode**: a code linked to exactly one product (and unit where applicable).
- **Batch**: a quantity of one product with an expiry date and cost, received from a purchase or
  opening stock.
- **Stock movement**: a change to a batch quantity with source document, time and user;
  adjustments and write-offs carry one of the predefined reasons (FR-058b).
- **Stock adjustment**: a requested stock change with its reason, requesting user and state:
  pending (stock unchanged) or approved (stock movement posted), with the approving Manager and
  time recorded (FR-058a). Further states, such as rejection, are defined in the Phase 2 data
  model.
- **Sale / sale line / payment**: a customer transaction, its items in packages or strips, and
  its payments by method.
- **Return**: a reversal of all or part of a sale (customer) or purchase (supplier).
- **Supplier / purchase / supplier payment**: purchasing records and supplier balance movements.
- **Customer account / debt movement**: credit sales, installment payments (each with its method)
  and balance history; each debt shows original amount, total paid and remaining balance.
- **Shift / cash movement / expense**: cash-drawer sessions and every cash in/out.
- **User / role / permission / audit entry**: identity, rights and the sensitive-action trail.
- **Backup record**: when, where, result and verification state of each backup.
- **License**: the signed perpetual or trial entitlement bound to one computer, with its transfer
  and recovery history.
- **Catalog source**: provenance and rights for bundled catalog data.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of core requirements in PROJECT_PLAN.md §2 map to at least one prioritized
  functional requirement with acceptance criteria.
- **SC-002**: 100% of open decisions in PROJECT_PLAN.md §6 not settled by the constitution have a
  recorded owner answer (0 clarification markers remain in this spec).
- **SC-003**: 13 of 13 constitution articles have a checklist entry with status and evidence.
- **SC-004**: Every risk rated high impact has a mitigation, an affected phase and a status.
- **SC-005**: The owner's approval of scope and high-impact decisions is recorded with a date.
- **SC-006**: An implementer of any later phase can answer "which business rule applies?" for
  money, stock, returns, expiry, licensing and backups from this spec alone, without inventing a
  rule.

## Assumptions

- The constitution v1.0.1 is final for this phase; any conflict found later is resolved by the
  Governance process, not by this spec.
- The first release serves one pharmacy on one computer; several staff share it with separate
  logins.
- Currency is EGP only.
- Detailed choices that a later phase can safely make (permission matrix detail, rounding
  implementation, report layouts, recommendation formula parameters, performance targets, shift
  rules detail, variant repository layout) are deferred; each is listed with its owning phase in
  `risk-register.md` §3.
- No Windows 7 SP1 test environment exists yet (recorded as R-01); Phase 1 cannot pass until one
  is available.
- Payment methods are recorded only; there is no card terminal, wallet or bank integration
  (owner decision D-04; consistent with Article I).
