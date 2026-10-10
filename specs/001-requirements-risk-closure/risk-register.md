# Risk Register and Decision Log: Phase 0 — Requirements Review and Risk Closure

**Created**: 2026-10-10
**Feature**: [spec.md](./spec.md)
**Governing authority**: `.specify/memory/constitution.md` v1.0.1

Ratings: Likelihood and Impact are **H** (high), **M** (medium) or **L** (low). Status is
**Open**, **Mitigating**, **Accepted** (owner accepts the residual risk) or **Closed**.
Ratings are initial planning estimates for review by the owner, not measured facts.

## 1. Risk Register

| ID | Risk | L | I | Affected phases | Mitigation | Status |
|----|------|---|---|-----------------|------------|--------|
| R-01 | **No Windows 7 SP1 test environment (x86 or x64) is available yet.** Article II requires compatibility claims to be backed by tests on the real OS and architecture; Phase 1's acceptance criteria cannot pass until such an environment exists. | H (certain today) | H | 1 (blocking), 9, 10, 11 | Owner confirmed on 2026-10-10 that none is available (D-01). Owner to provide Win7 SP1 x86 and x64 machines or licensed VMs before Phase 1 validation; Phase 1 may prepare test procedures meanwhile, but cannot claim compatibility. | Open — **blocks Phase 1 acceptance** |
| R-02 | The candidate runtime, database provider, installer or third-party libraries may not run, or may need OS prerequisites (for example, specific Windows updates), on Windows 7 SP1 x86/x64. | M | H | 1, 10 | Validate each dependency on bare and updated SP1 in Phase 1; record required prerequisites and whether they can be bundled offline; owner approves any stack change (Article XII). | Open |
| R-03 | Performance on 2–4 GB RAM machines may be unacceptable as data grows (years of sales, large catalog). | M | H | 1, 2, 8, 11 | Phase 1 sets measurable targets on a real low-spec machine; Phase 11 load tests with multi-year representative data volumes. | Open |
| R-04 | Arabic right-to-left text may print incorrectly on some 80mm thermal printers (character sets, driver behaviour). | M | M | 1, 5 | Test with the printer models provided for Phase 1 (none confirmed yet, R-24); keep a fallback printing method if text printing fails. | Open |
| R-05 | A verified Egyptian catalog with commercial redistribution rights may not be obtainable in time, or at all. | H | H | 4, 10 | Catalog source and redistribution rights: Owner: unconfirmed (D-03, 2026-10-10). Never fabricate entries; document provenance per source; fallback decided: empty catalog, CSV/Excel import and fast manual entry (FR-059a). | Open — **blocks the Phase 4 catalog deliverable and Phase 10 packaging of any bundled catalog** |
| R-06 | Bundled catalog prices and pack data can become outdated, leading to wrong prices at the counter. | H | M | 4, 5, 10 | Decision D-03 (update policy); show catalog version/date; pharmacy can override; never silently overwrite pharmacy edits unless the owner decides otherwise. | Open |
| R-07 | Legal or regulatory obligations for pharmacy software in Egypt are unknown to this project; a missed obligation could block sales or create liability. | M | H | 2, 5, 6, 11 | Legal review not completed: Owner: unconfirmed (D-13, 2026-10-10). Owner obtains qualified advice; no legal requirement is assumed; Phase 11 release blocked until applicable requirements are reviewed. | Open — **blocks commercial release (Phase 11)** |
| R-08 | Licensing may lock out legitimate users after hardware changes or failures. | M | H | 9 | Decision D-10; documented recovery procedure; licence problems never block access to data backup/export (Article VI). | Open |
| R-09 | Licensing will be bypassed by determined attackers. This is a residual risk; the licensing is not, and MUST NOT be presented as, a guarantee against bypass (Article VI). | H | M | 9 | Consistent with Article VI (never advertised as uncrackable); raise the effort needed rather than seek perfection. Regardless of this risk, licensing MUST NEVER endanger pharmacy data or block reports, backup or export (FR-094, FR-094d). | Accepted by the owner for the first release (2026-10-10) |
| R-10 | Loss or leak of the owner's private signing key would allow forged licences or stop issuance. | L | H | 9, 10 | Key kept offline under owner control, never in the repository or builds; documented backup and key-rotation procedure in Phase 9. | Open |
| R-11 | Data loss from disk failure, theft, ransomware or a backup stored on the same disk as the database. | M | H | 9 | Configurable destinations with non-C preference, multiple generations, warning when backup shares the database disk, removable-media guidance (D-11). | Open |
| R-12 | Power cuts or forced shutdowns during transactions could corrupt data or leave partial records. | H | H | 2, 5, 6, 7, 11 | Atomic transactions (FR-020/021); interrupted-operation tests with forced termination; database integrity check at startup. | Open |
| R-13 | Windows 7 no longer receives security updates; customer machines are exposed to malware. | H | H | all | Article II: compatibility is not a security guarantee; document known limitations and customer guidance; backups off the machine. | Accepted (documented limitation) |
| R-14 | A wrong system date or time (dead CMOS battery, manual change) distorts expiry alerts, reports, shift times and licence checks. | M | M | 2, 4, 7, 9 | Phase 2 defines date/time handling; detect and warn on clock moving backwards; avoid licence logic that destroys access on clock errors. | Open |
| R-15 | Unclear financial rules (cost method, price per batch, tax, discounts) lead to wrong profit and valuation figures. | H | H | 2, 4, 5, 6, 8 | Rules decided by D-05 (FR-027a–e, FR-028; owner answers 2026-10-10); rounding is defined in Phase 2; every figure has a documented formula and reconciliation tests. | Mitigating |
| R-16 | Barcode problems: one product with several barcodes, products without barcodes, the same barcode reused by different products over time. | H | M | 4, 5 | Multiple barcodes per product, duplicate prevention (FR-052), internal barcodes per D-12(d). | Open |
| R-17 | Scope growth: the product is a complete commercial release, and unmentioned features (insurance, prescriptions, multi-branch) may be requested mid-build. | M | H | all | Decision D-14 fixes the boundary; Article XIII requires a clear benefit and approval for additions. | Open |
| R-18 | Customer-specific variants drift from the core and become unmaintainable or leak between customers. | M | M | 10 | Article VII process; variant tracking against core releases defined in Phase 10. | Open |
| R-19 | Antivirus software may flag or quarantine an unsigned installer or the licensing component on customer machines. | M | M | 10, 11 | Evaluate code signing (cost and Windows 7 support of the signature type) in Phase 10; test with common antivirus products. | Open |
| R-20 | Project plan gaps: the "Goal:" line is empty for Phases 3–11 in PROJECT_PLAN.md. | H (certain) | L | 3–11 | Goals for Phases 3–11 were written into PROJECT_PLAN.md on 2026-10-10 from each phase's deliverables and acceptance criteria; each phase's specify step still asks the owner to confirm its goal. | Closed |
| R-21 | **Exact list of newer Windows versions/editions is unconfirmed** (Owner: unconfirmed, D-01, 2026-10-10). Without it the compatibility matrix and its test set are undefined. | H (certain today) | M | 1 (blocking matrix approval), 9, 10, 11 | Phase 1 proposes the compatibility matrix; owner approves it before Phase 1 acceptance. No newer version is claimed as supported until listed and tested. | Open — **blocks Phase 1 acceptance** |
| R-22 | **No physical 2–4 GB RAM test PC is confirmed** (Owner: unconfirmed, D-01c). Article II requires performance evaluation on representative low-spec hardware. | H (certain today) | H | 1 (blocking performance targets), 11 | Owner to confirm a real low-spec machine before Phase 1 sets performance targets; virtual machines alone are not accepted as evidence. | Open — **blocks Phase 1 acceptance** |
| R-23 | **Windows 7 update level on customer machines is unconfirmed** (Owner: unconfirmed, D-01d). Dependencies (for example the .NET Framework 4.8 runtime) may need updates absent on bare SP1. | M | H | 1 (blocking), 10 | Phase 1 validates the offline installer and every dependency on both bare SP1 and updated SP1, x86 and x64; required prerequisites are bundled offline or documented. | Open — **blocks Phase 1 acceptance** |
| R-24 | **No test printer model is confirmed** (Owner: unconfirmed, D-12). Without real A4 and 80mm ESC/POS printers (and a drawer, if any), printing, Arabic RTL output and drawer opening cannot be validated. | H (certain today) | M | 1 (blocking hardware validation), 5 | Owner to name and provide at least one 80mm ESC/POS thermal printer and one A4 printer for Phase 1; only tested models are claimed as supported. | Open — **blocks Phase 1 hardware validation** |
| R-25 | **Licence recovery response time is unconfirmed** (Owner: unconfirmed, D-10f). A pharmacy whose PC fails may wait an unknown time for a recovery licence. | M | M | 9, 11 | Licence problems never block reports, backup or export (FR-094d); owner sets or documents a response time before commercial release. | Open |
| R-26 | Backups are unencrypted in the initial release (FR-047e, C-01): anyone who copies a backup file can read customer names, debts and sales records. | M | M | 9, 10 | User and administrator documentation (Phase 10) advises keeping backup media physically secure; encryption may be added later only with a safe key-recovery method (FR-047e). | Accepted (owner decision C-01, 2026-10-10) |

## 2. Open Decision Log (owner input required)

Each decision below corresponds to one clarification marker in [spec.md](./spec.md). Decisions
are grouped by topic. A decision is resolved only when the owner's answer is recorded here and in
`spec.md`.

| ID | Topic (PROJECT_PLAN.md §6 item) | Spec location | Blocks phases | Status |
|----|---------------------------------|---------------|---------------|--------|
| D-01 | Supported Windows versions and available test environments (§6.1) | FR-012, FR-012a, FR-012b | 1 (acceptance), 9–11 | Resolved 2026-10-10: Windows 7 SP1 x86/x64 plus newer supported versions; exact list deferred to the Phase 1 compatibility matrix (owner approval). Owner: unconfirmed — test environments (R-01), low-spec PC (R-22), update level (R-23), newer-version list (R-21) |
| D-02 | Phase 1 technology baseline and owner constraints on alternatives (§6.2) | FR-016 | 1 (start) | Resolved 2026-10-10: C# WinForms, .NET Framework 4.8, SQLite approved as Phase 1 candidates subject to compatibility tests; free, commercially compatible dependencies preferred; stack changes per Article XII |
| D-03 | Catalog source, redistribution rights, update policy, initial scope (§6.3) | FR-059, FR-059a | 4, 10 | Resolved 2026-10-10: empty catalog, CSV/Excel import and fast manual entry. Owner: unconfirmed — licensed source and rights (R-05). Catalog fields, scope and update policy deferred until a source exists |
| D-04 | Supported payment methods, split and partial payment (§6.4) | FR-062 | 2, 5, 7, 8 | Resolved 2026-10-10: cash, credit and a configurable list of non-cash methods; split and partial-credit payments allowed; no terminal integration |
| D-05 | Financial and accounting rules: cost method, batch pricing, strip price, tax, discounts, net profit (§6.4) | FR-027, FR-027a–e, FR-028 | 2, 4, 5, 6, 8 | Resolved 2026-10-10: (a) COGS uses actual batch cost; (b) one selling price per product; (c) strip price derived from pack price and conversion, optional per-product override; (d) tax-inclusive, no tax recording, no e-invoicing; (e) fixed or percentage discounts within a per-role maximum (line/invoice scope deferred to Phase 5); (f) net profit = gross profit − expenses − write-offs |
| D-06 | Expiry policy: selling expired stock, batch selection, alert window, stagnant definition, expiry precision (§6.5) | FR-056, FR-056a–c | 2, 4, 5, 8 | Resolved 2026-10-10: (a) expired batches never sold; (b) earliest-expiring batch selected automatically; (c) 3-month alert, configurable; (d) stagnant after 90 days without sales, configurable; (e) expiry recorded as printed (day or month/year); when a month/year expiry counts as expired deferred to Phase 4 |
| D-07 | Customer and supplier returns policy (§6.5) | FR-065, FR-065a–e | 2, 5, 6, 7 | Resolved 2026-10-10: (a) 14-day configurable window; (b) original sale required; (c) strip returns where applicable; (d) returned stock sellable by default, with a single "damaged" option posting a damage write-off in the same transaction (round-2 refinement); (e) refund by cash or debt reduction; (f) supplier returns, including expired stock, reduce supplier balance |
| D-08 | Negative stock policy (§6.5) | FR-057 | 2, 4, 5 | Resolved 2026-10-10: blocked; no override in the initial scope |
| D-09 | Inventory adjustment and stocktaking policy (§6.5) | FR-058, FR-058a–d | 2, 4, 8 | Resolved 2026-10-10: all three roles may post adjustments; Manager approval for every Cashier adjustment and any adjustment above a configurable threshold (C-04); four predefined reasons (return to supplier removed by C-03); full and partial stocktaking (concurrent-sale method deferred to Phase 2/4); write-offs as a separate loss line |
| D-10 | License model, binding, recovery, and behaviour when unlicensed (§6.6) | FR-094, FR-094a–e | 9 (and 3 startup flow) | Resolved 2026-10-10: perpetual, one PC, 30-day trial, up to two owner-approved transfers per year; invalid licence never blocks reports/backup/export. Deferred to Phase 9: offline revocation, sales when invalid. Owner: unconfirmed — recovery response time (R-25) |
| D-11 | Backup schedule, retention, restore authorization, backup protection (§6.7) | FR-047, FR-047a–e | 9 | Resolved 2026-10-10: shift-close, configurable daily and manual backups; 7 daily / 4 weekly / 6 monthly; Manager-only restore with confirmation; same-disk warning; no encryption in the initial release |
| D-12 | Minimum printers, scanners, internal barcodes, cash drawer (§6.8) | FR-096, FR-096a–d | 1 (hardware), 3, 5 | Resolved 2026-10-10: USB keyboard-style scanners with Enter; A4 and 80mm ESC/POS printers via Windows drivers; untested models not guaranteed; internal non-duplicate barcodes; drawer via receipt printer on cash sales. Owner: unconfirmed — test printer models (R-24) |
| D-13 | Legal and regulatory requirements (§6.9) | FR-098 | 2, 5, 6, 11 | Answered 2026-10-10: legal review not completed; no legal requirement assumed. Owner: unconfirmed (R-07) — Phase 11 blocked until reviewed |
| D-14 | Scope boundary for features the plan does not mention | Product Scope and Non-Goals | 2, 4, 5, 6 | Resolved 2026-10-10: all seven items are non-goals (NG-11 to NG-17); non-medicine goods sold as ordinary products |

Settled by the constitution (not asked again): offline-only operation (Art. I); Windows 7 SP1
x86/x64 target (Art. II); atomicity and reversal-only corrections (Art. III); Arabic RTL default,
no mandatory manufacturer, package/strip only, per-product conversion, 80mm and A4 printing
(Art. IV); Manager/Pharmacist/Cashier roles and the list of sensitive actions (Art. V); offline
licensing with an unembedded private key and no data destruction (Art. VI); variant isolation
(Art. VII); deterministic advisory recommendations (Art. VIII); shift fields, expense categories,
expiry alerts and report (Art. IX); backup safeguards (Art. X); single-computer scope and
non-goals (Art. XIII).

## 3. Decisions Deferred to Later Phases (not blocking Phase 0)

These are safe for the named phase's specification to decide, within the constitution and the
answers above. They are listed so they are not forgotten or silently invented.

| Item | Owning phase | Depends on |
|------|--------------|------------|
| Measurable performance targets (startup, scan-to-line, report time, memory ceiling) | 1 | D-01 |
| Final technology stack | 1 (owner approval) | D-02 |
| Money rounding implementation and display precision | 2 | D-05 |
| Date/time handling and time-zone rules | 2 | — |
| Database migration and upgrade strategy | 2 | Phase 1 stack |
| Detailed permission matrix per role (including discount limits) | 3 | D-05(e) |
| Product form fields and search behaviour | 4 | D-03 |
| Customer credit limits and overdue handling | 6 | D-04 |
| Shift rules (one open shift at a time, multiple cashiers per shift, blind count) | 7 | D-04 |
| Report layouts, filters and CSV format | 8 | D-05 |
| Recommendation formula parameters (safety stock, lead time defaults) | 8 | D-06 |
| Customer-variant repository layout and release numbering | 10 | — |
| Code signing approach | 10 | R-19 |
| Exact list of newer Windows versions/editions (compatibility matrix, owner approval) | 1 | D-01 |
| Discount scope: per line, per invoice or both | 5 | D-05(e) |
| When a month/year-only expiry counts as expired | 4 | D-06(e) |
| Method for reconciling sales made during a stock count | 2/4 | D-09(c) |
| Offline revocation of an old licence on transfer | 9 | D-10(c) |
| Whether sales are allowed with a missing, invalid or expired licence or trial | 9 | D-10(d) |
| Catalog fields, scope and update policy | 4 (once a licensed source exists) | D-03, R-05 |

## 4. Possible Conflicts Decided by the Owner

Reported by the clarify round-2 run on 2026-10-10 and recorded here so they are not lost. All five
were decided by the owner in clarify round 3 on 2026-10-10 (see spec.md Clarifications).

| ID | Possible conflict | Spec location | Status |
|----|-------------------|---------------|--------|
| C-01 | No backup encryption (FR-047e) vs. Article VI: "The product MUST retain a safe, documented method for protecting and recovering customer data." The article is about licensing, so this is probably not a conflict, but the owner should confirm. | FR-047e | Resolved 2026-10-10: no conflict; Article VI is met by the documented backup and restore; readable-backup risk recorded as R-26 |
| C-02 | A return marked "damaged" posts a damage write-off (FR-065e). It is not specified whether that write-off is subject to the Manager-approval threshold for adjustments (FR-058a), or what happens when a Cashier processes the return. | FR-058a, FR-065e | Resolved 2026-10-10: the write-off is part of the return; return permission only, audited with the return, no adjustment approval |
| C-03 | Two routes for supplier returns: "return to supplier" is an adjustment reason (FR-058b), and supplier returns are also separate documents that reduce the supplier balance (FR-065d). Without a rule for which route applies, the same event could be posted twice. | FR-058b, FR-065d | Resolved 2026-10-10: supplier-return documents only (stock and balance in one transaction); "return to supplier" removed from adjustment reasons |
| C-04 | Who may post adjustments: the owner named only Pharmacists, with Manager approval above a threshold. FR-058a says "Pharmacists (and Managers)"; the Manager part was inferred, not stated by the owner. Whether Cashiers may adjust stock is unspecified. | FR-058a | Resolved 2026-10-10: all three roles may post; every Cashier adjustment and any above the threshold needs Manager approval |
| C-05 | Near-expiry alert window granularity: "configurable" (FR-056a), but whether it is one global setting or per product was not stated. | FR-056a | Resolved 2026-10-10: one pharmacy-wide setting, default 3 months; no per-product override |
