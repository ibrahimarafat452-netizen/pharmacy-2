# Change proposal — Owner-approved deferral of Phase 1 validation

**Feature**: cross-phase (`PROJECT_PLAN.md`, `specs/002-legacy-compat-validation/spec.md`) ·
**Created**: 2026-10-11 · **State**: approved with amendment A1 (2026-10-11)

A material change to the approved plan and the approved Phase 1 specification, presented with all
five Article XII items. Nothing in this proposal is applied until the owner explicitly approves it.

## Owner conditions (2026-10-11)

1. Phase 1 remains explicitly **NOT ACCEPTED** until its unchanged gate returns exit 0.
2. No Windows 7 compatibility claim, and no pilot or production release, before full Phase 1
   acceptance.
3. All existing evidence rules and gate behaviour are preserved; no evidence is fabricated and no
   blocked or unrun test is reported as passed.
4. The approved technology constraints are kept, and the risk that real compatibility testing may
   require rework is documented.

## 1. Problem

The owner has decided to defer all Phase 1 testing that needs machines, VMs or hardware, including
the M-07 checks on the developer PC, until the product is substantially complete, and to build the
product first. The approved documents do not allow this:

- `PROJECT_PLAN.md` section 5, step 7: "Proceed to the next phase only after the current phase
  passes its acceptance gate."
- Phase 1 spec FR-071 allows an early Phase 2 only "once every validation test that is possible on
  the available environments has passed". The developer PC (M-07) is available, so its checks are
  possible and have not been run.
- The Phase 1 gate returns exit 2 (early Phase 2 condition) only when at least one real evidence
  record exists. With no evidence it returns exit 1.

Current state (2026-10-11): Phase 1 tooling is complete on the developer machine (71 of 78 tasks;
T037 partial, T052 blocked, T074–T078 not triggered); no owner-run evidence exists; the gate returns
exit 1 with "FAIL: no evidence records found".

## 2. Proposed change and alternatives

### Proposed change

Add a third, explicitly owner-approved route: Phases 2–10 may proceed while Phase 1 validation is
**deferred**. The deferral is a recorded owner decision, not a gate result. The gate, its exit codes,
its self-test and every evidence rule stay unchanged, and the gate continues to report Phase 1
honestly (today: exit 1).

**Binding rules while the deferral is in force**

- **D1 — Status.** Phase 1 is NOT ACCEPTED. Every phase specification, plan, review and status
  report states: "Phase 1: NOT ACCEPTED — validation deferred under CP-002; Windows 7
  compatibility: unverified."
- **D2 — No claims.** No document, screen, installer text, release note or sales material may
  claim Windows 7 compatibility, low-spec performance, or scanner, printer or cash-drawer support
  until the corresponding Phase 1 checks pass.
- **D3 — No release.** No pilot deployment, customer installation or production release before the
  Phase 1 gate returns exit 0. Installers built in Phase 10 are for internal testing only.
- **D4 — Provisional baseline.** The technology baseline is provisional, and product code must stay
  inside it: C# 7.3 on .NET Framework 4.8, Windows Forms, x86 as the default build;
  System.Data.SQLite 2.0.4 with the pinned native library, never using the restricted APIs of
  `validation/phase1/decision/dependency-notes.md` section 1.9; Inno Setup 6.7.3; no Windows API
  or .NET feature unavailable on Windows 7 SP1; no new dependency without a change proposal.
- **D5 — Containment.** Data access stays behind a persistence layer, and printing, scanning and
  installer specifics stay behind their own small interfaces (Article XI separation), so that a
  later provider or device change is local.
- **D6 — Revisit on failure.** If a Phase 1 check later fails, the affected design is revisited
  under Article XII before work on the affected area continues, and FR-008 applies to any
  technology change.
- **D7 — Ending the deferral.** The owner may end the deferral at any time. It ends no later than
  the start of Phase 11, whose pilot deployment requires Phase 1 gate exit 0. Running the deferred
  checks earlier (for example M-07 on the developer PC) is allowed and recommended, and lowers the
  rework risk.

### Alternatives considered

| Alternative | Why not preferred |
|-------------|-------------------|
| Run M-07 now and use the existing early route (FR-071, gate exit 2) | Lowest risk, but the owner has decided to defer all testing. |
| Change the gate so that no evidence returns exit 2 | Weakens the gate and blurs honest reporting; rejected by the owner's conditions. |
| Mark Phase 1 accepted with conditions | False: no evidence exists; contradicts Article II. |
| Suspend the plan's phase order entirely | Larger change than needed; loses the Phase 11 release safeguard. |
| **Recorded owner deferral with an unchanged gate (proposed)** | Smallest change; product work proceeds; Phase 1 status stays honest; release stays blocked. |

## 3. Windows 7 and 32-bit impact

Windows 7 SP1 x86/x64 remains the target (Article II), but it stays **unverified** until the
Phase 1 checks pass. Product work is built and tested on Windows 10/11 only, which proves nothing
about Windows 7 (Article II: compilation on a modern computer is not evidence). Rules D2–D5 keep the
product inside the baseline that Phase 1 will test, so that the deferred checks still apply to the
real product. The checks already on the developer machine (native-library export comparison,
restricted-API scan) showed no Windows 7 blocker, but they are not compatibility evidence.

## 4. Effects on data, security, performance, maintainability and delivery

- **Data**: none now. Risk: if Phase 1 forces a SQLite provider change, the database layer may need
  rework; the schema and the data stay SQLite-compatible.
- **Security**: none; permission and audit rules are unchanged.
- **Performance**: unmeasured on low-spec hardware until the PF checks run; the approved targets
  (FR-062) do not exist yet. Product phases keep Article IV resource limits and record rough
  timings on the developer PC, which are never presented as low-spec results.
- **Maintainability**: neutral; D5 improves isolation.
- **Delivery**: product work can start now. Rework risk (below) moves to the end of the project,
  where it is more expensive to fix.

### Rework risk if later testing fails

| Possible finding on Windows 7 or hardware | Likely effect | Mitigation |
|--------------------------------------------|---------------|------------|
| .NET 4.8 does not install on bare SP1 | Installer prerequisites or a documented minimum update level | Inno Setup prerequisites only |
| Native SQLite needs a Visual C++ runtime or UCRT | Add the runtime to the installer (T074) | Installer only |
| SQLite provider unusable | Replace the provider (T075/T076) | D5 persistence layer limits the change |
| Arabic rendering or Western digits wrong on Windows 7 | Font, text-drawing or formatting changes | Design-system tokens and shared components (CP-001) |
| Scanner, printer or cash-drawer problem | Device-specific changes | D5 device interfaces |
| Low-spec PC too slow or short of memory | Performance work in affected screens | Article IV limits from the start |
| Windows Forms itself unsuitable | Major UI rework | Considered unlikely because Microsoft lists Windows 7 SP1 as supported by .NET Framework 4.8, but not yet tested; accepted risk |

## 5. Required tests and migration or rollback steps

**Acceptance conditions of this change** (all must hold once applied):

- The gate script, its self-test and the evidence schema are byte-for-byte unchanged, and the gate
  self-test still passes all cases (a)–(k).
- The Phase 1 gate run after applying still returns exit 1 with its current failures.
- `PROJECT_PLAN.md`, `spec.md` and `HANDOFF.md` contain the wording below and no other change.
- No evidence file, matrix row status, check status or task checkbox changes.

**Tests later**: the full Phase 1 validation, unchanged, must reach gate exit 0 before Phase 11 pilot
deployment; each product phase must keep to D4 (reviewed in each phase's plan and code review).

**Migration**: none; no product code or data exists yet.

**Rollback**: revert the edits listed below. Revoking the deferral after product work has started
pauses product work at the next phase boundary until Phase 1 is accepted under the original rules;
existing product code stays in the repository, unreleased.

## 6. Exact files and wording

### Unchanged

`.specify/memory/constitution.md`; `.specify/phase-plans/phase-01-gate.ps1`;
`validation/phase1/tests/gate/Test-Phase1Gate.ps1`; the evidence schema and all contracts;
`validation/phase1/checks/*`; `validation/phase1/decision/decision-record.md` (read by the gate);
`specs/002-legacy-compat-validation/tasks.md`; all evidence.

### `PROJECT_PLAN.md`

1. Phase 1, after "Acceptance criteria" — add:

   > Deferral: under change proposal CP-002 (approved _date_), the owner deferred Phase 1 validation
   > while Phases 2–10 proceed. Phase 1 remains NOT ACCEPTED and the technology baseline remains
   > provisional until the unchanged Phase 1 gate returns exit 0; Windows 7 compatibility is
   > unverified until then. No pilot deployment, customer installation or production release may
   > occur before then; installers built before then are for internal testing only. _(A1)_

2. Phase 11 "Acceptance criteria" — add as the first item:

   > - Phase 1 is accepted (Phase 1 gate exit 0) before the pilot deployment begins.

3. Section 5, step 7 — replace with:

   > 7. Proceed to the next phase only after the current phase passes its acceptance gate, except
   >    that Phases 2–10 may proceed while Phase 1 validation is deferred under CP-002; that deferral
   >    never counts as Phase 1 acceptance and ends no later than the start of Phase 11.

### `specs/002-legacy-compat-validation/spec.md`

1. Under "Clarifications", a new `### Session <approval date>` with:

   > - Q: May product phases proceed while all Phase 1 testing is deferred, including checks possible
   >   on the developer PC (FR-072)? → A: Yes, under change proposal CP-002: Phase 1 stays NOT
   >   ACCEPTED, the gate is unchanged, no Windows 7 claim and no pilot or release before gate
   >   exit 0.

2. After FR-071 — add:

   > - **FR-072**: The owner MAY defer Phase 1 validation, including checks possible on available
   >   environments, and authorise Phases 2–10 under change proposal CP-002. While deferred: Phase 1
   >   is NOT ACCEPTED and is reported as such; the Phase 1 gate and evidence rules are unchanged;
   >   no Windows 7, low-spec or hardware compatibility claim is made; product code stays within
   >   the technology baseline and its restrictions; and no pilot deployment, customer installation
   >   or production release occurs before the gate returns exit 0 (FR-070). _(A1)_ A later failed check is
   >   handled under FR-071's revisit rule and FR-008.

### `validation/phase1/HANDOFF.md`

After the introduction, add:

> **Status (CP-002):** validation is deferred by owner decision. Phase 1 is NOT ACCEPTED; Windows 7
> compatibility is unverified. Everything below remains required before any pilot or release.

### New file

This proposal, `validation/phase1/decision/change-proposals/CP-002-deferred-phase1-validation.md`,
with its state set to approved and the approval recorded.

## 7. Separate, optional decision (not part of this approval)

The Phase 1 tooling, plan documents and gate script are uncommitted because commits wait for the
gate. The owner may separately approve committing them labelled "Phase 1 incomplete — NOT
ACCEPTED", to preserve the work. This does not change acceptance.

## Approval

Approved by the project owner (ibrahim arafat) on 2026-10-11: "Approve CP-002 with amendment A1."

Amendment A1: the full D3 release ban (no pilot deployment, customer installation or production
release before gate exit 0; earlier installers internal only) is written into the PROJECT_PLAN.md`nPhase 1 deferral paragraph and into FR-072, not only into this proposal.

Applied on 2026-10-11 to PROJECT_PLAN.md, specs/002-legacy-compat-validation/spec.md and
alidation/phase1/HANDOFF.md. The optional commit in section 7 was not part of this approval.
