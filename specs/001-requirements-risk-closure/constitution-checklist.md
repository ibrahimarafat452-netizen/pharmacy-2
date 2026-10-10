# Constitution Compliance Checklist: Phase 0 — Requirements Review and Risk Closure

**Created**: 2026-10-10
**Feature**: [spec.md](./spec.md)
**Constitution**: `.specify/memory/constitution.md` v1.0.1 (ratified 2026-10-10)

Status values:

- **Covered** — the requirements baseline states the article's rules; evidence comes from the
  listed later phases.
- **Covered, decision pending** — covered, but an open owner decision (D-xx in
  `risk-register.md` §2) must be answered before the affected phase.
- **Covered, verification blocked** — covered, but the required evidence cannot be produced yet
  (see the referenced risk).

Phase 0 itself writes no code; every entry below checks the requirements baseline, not an
implementation.

## Article I — Offline-First Architecture

- [x] **Status**: Covered
- **Requirements**: FR-010, FR-011, FR-014; NG-02, NG-03, NG-04; FR-097 (no production data in
  source control).
- **Phase 0 check**: No requirement depends on internet access. Payment methods are recorded only,
  with no online integration (Assumptions; D-04). Licensing is offline (FR-094).
- **Evidence required later**: offline install/activation/operation/backup/restore test on every
  supported OS (Phases 1, 10, 11); network monitoring showing no outbound traffic (Phase 11).

## Article II — Legacy Windows Compatibility

- [x] **Status**: Covered, verification blocked (R-01, R-21, R-22, R-23); D-01 and D-02 resolved
  2026-10-10
- **Requirements**: FR-012, FR-012a, FR-012b, FR-013, FR-015, FR-016.
- **Phase 0 check**: Target is Windows 7 SP1 x86/x64 plus newer versions; the exact list of newer
  versions is deferred to the owner-approved Phase 1 compatibility matrix (D-01, R-21). The Phase 1
  technology candidates are approved subject to tests (D-02, FR-016). No Windows 7 SP1 x86/x64
  test environment exists (R-01), and a low-spec PC (R-22) and customer update level (R-23) are
  unconfirmed, so Phase 1 cannot pass yet. The Windows 7 security limitation is recorded (R-13,
  NG-10).
- **Evidence required later**: reproducible compatibility tests on real or representative
  Windows 7 SP1 x86 and x64 and each newer version in the matrix; memory measurements on a
  2–4 GB machine (Phases 1, 11).

## Article III — Data Integrity and Financial Accuracy

- [x] **Status**: Covered; D-05 to D-09 resolved 2026-10-10; possible conflicts C-02 to C-04
  resolved 2026-10-10 (`risk-register.md` §4)
- **Requirements**: FR-020 to FR-028, FR-056 to FR-058d, FR-065 to FR-065e, FR-074, FR-084,
  FR-091.
- **Phase 0 check**: Atomicity, reversal-only corrections, traceable stock movements and distinct
  financial figures are stated. Cost method, pricing, returns, negative stock and adjustment rules
  are recorded owner answers; details deferred to later phases are listed in `risk-register.md`
  §3.
- **Evidence required later**: interrupted-transaction tests, reconciliation tests and
  backup/restore consistency tests (Phases 2, 5–9, 11).

## Article IV — Simplicity and Professional User Experience

- [x] **Status**: Covered; D-12 resolved 2026-10-10; hardware verification blocked (R-24)
- **Requirements**: FR-050, FR-051, FR-060, FR-061, FR-066, FR-095, FR-096 to FR-096d; NG-06,
  NG-08.
- **Phase 0 check**: Arabic RTL default, no mandatory manufacturer, free-form medicine names,
  package/strip sales only, per-product conversion, fast scanning, 80mm and A4 printing, no heavy
  animation and recovery-oriented error messages are all stated. Scanner and printer classes are
  decided (D-12); no test printer model is confirmed (R-24).
- **Evidence required later**: Arabic RTL usability tests and hardware tests (Phases 1, 3, 5, 11).

## Article V — Security, Permissions, and Accountability

- [x] **Status**: Covered (detailed permission matrix deferred to Phase 3)
- **Requirements**: FR-030 to FR-035, FR-031 list of sensitive actions, FR-047c restore
  authority (D-11), FR-058a adjustment roles and Manager approval (C-04), FR-065e damaged-return
  write-off under return permission (C-02).
- **Phase 0 check**: Roles, permission-controlled sensitive actions, audit trail, no plaintext
  secrets and enforcement in business logic are stated. Every Cashier adjustment and any
  adjustment above the threshold waits for Manager approval; a damaged-return write-off requires
  the return permission and is audited with the return.
- **Evidence required later**: permission-bypass and audit tests (Phases 3, 11).

## Article VI — Offline Licensing and Product Ownership

- [x] **Status**: Covered; D-10 resolved 2026-10-10 (offline revocation and sales-when-invalid
  deferred to Phase 9); possible conflict C-01 resolved 2026-10-10 as no conflict (R-26)
- **Requirements**: FR-094 to FR-094e; NG-03, NG-10; risks R-08, R-09, R-10, R-25.
- **Phase 0 check**: Local validation, unembedded private key, recovery procedure and no data
  destruction are stated. The licence is bound to one PC (FR-094a), satisfying the SHOULD.
- **Evidence required later**: offline licence tests, key-absence scan of builds, tested recovery
  procedure (Phases 9, 10).

## Article VII — Core Product and Customer-Specific Versions

- [x] **Status**: Covered (repository layout deferred to Phase 10)
- **Requirements**: FR-097; risk R-18.
- **Phase 0 check**: Clean core, documented variant lineage, isolation, no automatic merge,
  release identification and no secrets in source control are stated.
- **Evidence required later**: reproducible customer build from documented source and
  configuration; repository secret scan (Phase 10).

## Article VIII — Explainable Local Intelligence

- [x] **Status**: Covered (formula parameters deferred to Phase 8; depends on D-06)
- **Requirements**: FR-093; NG-04, NG-07.
- **Phase 0 check**: Local deterministic rules, explained factors, honest handling of thin
  history, expiry awareness, advisory-only and no clinical advice are stated.
- **Evidence required later**: determinism and insufficient-history tests (Phase 8).

## Article IX — Useful Reports and Cash Management

- [x] **Status**: Covered; D-04, D-05, D-06 resolved 2026-10-10; possible conflict C-05 resolved
  2026-10-10 (`risk-register.md` §4)
- **Requirements**: FR-055, FR-056 to FR-056c, FR-062, FR-074, FR-080 to FR-084, FR-090 to FR-092.
- **Phase 0 check**: Shift fields, separation of cash/non-cash/credit, configurable expense
  categories, documented formulas, expiry alerts and the near-expiry/stagnant report are stated.
  Alert window (3 months) and stagnant definition (90 days) are set by D-06; payment methods by
  D-04.
- **Evidence required later**: report reconciliation tests and shift tests (Phases 7, 8, 11).

## Article X — Backup, Recovery, and Availability

- [x] **Status**: Covered; D-11 resolved 2026-10-10; verification blocked on target OS (R-01)
- **Requirements**: FR-040 to FR-047e; risk R-11.
- **Phase 0 check**: Automatic/manual backups, configurable destination with non-C preference,
  honest failure reporting, integrity checks, pre-restore protection and last-backup display are
  stated. Schedule, retention, restore authority and same-disk warning are set by D-11.
- **Evidence required later**: failure and recovery tests on each supported environment
  (Phases 9, 11).

## Article XI — Engineering Quality and Verification

- [x] **Status**: Covered
- **Requirements**: FR-001 to FR-008 (requirements and acceptance criteria before
  implementation); acceptance criteria for groups A–N.
- **Phase 0 check**: Every product requirement group has acceptance criteria; release-blocking
  failure classes are marked P1. Separation of responsibilities and test strategy are Phase 2
  deliverables.
- **Evidence required later**: test strategy (Phase 2), integration and deployment tests per
  architecture (Phases 2–11), release test evidence (Phase 11).

## Article XII — Controlled Technical Flexibility

- [x] **Status**: Covered; D-02 resolved 2026-10-10
- **Requirements**: FR-015, FR-016; risk-register §3 (deferred decisions with owning phases).
- **Phase 0 check**: No technology, business rule or scope item was decided without the owner.
  Open items are routed to the owner (§2) or to a named later phase (§3). Phase 0 cannot
  complete without owner approval (FR-008).
- **Evidence required later**: documented change proposals with owner approval for any material
  change (all phases, notably Phase 1).

## Article XIII — Scope Discipline

- [x] **Status**: Covered; D-14 resolved 2026-10-10; D-13 answered (legal review not done,
  Phase 11 blocked, R-07)
- **Requirements**: NG-01 to NG-17, FR-027c, FR-061, FR-067, FR-098; scope boundary D-14.
- **Phase 0 check**: Single-computer scope, excluded features and the internal-receipt rule are
  stated as non-goals. Features the plan does not mention are non-goals by owner decision
  (NG-11 to NG-17). No tax/receipt or other legal obligation is assumed (D-13).
- **Evidence required later**: owner-approved scope (Phase 0 sign-off); receipt review against
  D-13 answers (Phase 5).

## Notes

- An entry is ticked once its decisions are answered and the owner approves the baseline. All 13
  were ticked on 2026-10-10 when the owner approved Phase 0. A tick records baseline approval, not
  verification: the "Evidence required later" items and the blocked verifications (R-01, R-21 to
  R-24) remain open for their phases.
- No conflicts between `PROJECT_PLAN.md` and the constitution were found. Gaps noted: the "Goal:"
  line was empty for Phases 3–11 in the plan (R-20, closed 2026-10-10), and "compatible newer
  Windows versions" in Article II needs a concrete list (D-01, deferred to Phase 1, R-21).
- Statuses refreshed 2026-10-10 after clarify round 2. Possible conflicts between owner answers
  and the constitution or each other are listed in `risk-register.md` §4; the owner decided all
  five in clarify round 3 (2026-10-10).
