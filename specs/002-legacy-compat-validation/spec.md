# Feature Specification: Phase 1 — Legacy Compatibility and Technology Validation

**Feature Branch**: `002-legacy-compat-validation` (spec directory only; work stays on `main`)

**Created**: 2026-10-10

**Status**: Approved by the owner on 2026-10-10, including the compatibility matrix M-01 to M-07
(FR-001a); specify answers and clarify session recorded below

**Input**: User description: "Phase 1: Legacy Compatibility and Technology Validation (see PROJECT_PLAN.md Phase 1, constitution v1.0.1, and approved Phase 0 spec specs/001-requirements-risk-closure)"

**Governing documents**: `.specify/memory/constitution.md` v1.0.1, `PROJECT_PLAN.md` (Phase 1)
and the approved Phase 0 baseline `specs/001-requirements-risk-closure/` (spec, risk register,
constitution checklist). Where this spec and the constitution differ, the constitution wins.
This spec does not change any Phase 0 decision.

**Goal** (PROJECT_PLAN.md): Prove that the proposed technology can deliver the required offline
Windows application.

**Nature of this phase**: Phase 1 is a validation phase. It validates the candidate technology
directly through focused technology, installation, scanner, printer and performance tests (see
"Validation test" in Key Entities); it builds no standalone prototype or demo application. It
produces test procedures and evidence, and ends with a compatibility decision. It delivers no
pharmacy business feature.

## Clarifications

### Session 2026-10-10

- Q: Which newer Windows versions and architectures must be supported alongside Windows 7 SP1 x86
  and x64 (FR-001, Phase 0 D-01(a))? → A: Windows 10 x86 and x64, and Windows 11 x64.
- Q: Is the validation prototype throwaway, or may it become starting code for later phases
  (FR-005)? → A: No standalone throwaway prototype. Compatibility is validated directly through
  focused technology, installation, scanner, printer and performance tests; no separate demo
  application is built.
- Q: May Phase 2 start before Windows 7 and hardware testing is possible (FR-071)? → A: Yes, once
  the validation that is possible on available environments passes; unresolved hardware and
  Windows 7 risks are documented, and the architecture is revisited if later Windows 7 or hardware
  tests reveal an incompatibility.
- Q: May a focused test use its own window or install package (FR-005)? → A: Yes, a minimal window
  or a minimal install package is allowed; no standalone demo application.
- Q: Which Windows editions does the matrix test (FR-001a)? → A: Phase 1 proposes editions based on
  practical availability; the matrix stays a proposal until the owner approves it.
- Q: Must a Windows 10 x86 machine be bought if none is available (FR-001b)? → A: No. If no
  Windows 10 x86 environment is available, its tests are marked Blocked and the limitation is
  documented.
- Q: Do the earlier choices on performance measurement, test volumes and data-preserving uninstall
  stand (FR-051, FR-060 to FR-062, SC-004 to SC-006)? → A: Yes, unchanged.
- Q: Who runs the Windows 7, scanner, printer and low-spec tests, and are checks scripted or
  manual (FR-002, SC-003)? → A: The owner runs them; every check that can be automated is a
  script that collects its own evidence, physical checks are short written procedures with a
  pass/fail form, and reproduction is the owner re-running the scripts on a second occasion.
- Q: How close must three repeated low-spec measurements be to count as reliable (User Story 4,
  FR-060a)? → A: Each run within 15% of the three-run average; otherwise repeat the measurement.

## User Scenarios & Testing *(mandatory)*

The "users" of this phase are the project owner, who approves the compatibility decision, the
compatibility matrix, the performance targets and any technology change; and the teams of
Phases 2–11, who build on the validated technology.

### User Story 1 - Owner approves the compatibility matrix and test environments (Priority: P1)

Before any compatibility claim is made, the owner sees a proposed list of every Windows version,
edition and architecture the product will support, with the test environment for each, and
approves it.

**Why this priority**: Phase 0 deferred the list of newer Windows versions to this phase with
owner approval (FR-012, R-21). Without an approved matrix, no test set exists and no
compatibility claim can be made (Article II).

**Independent Test**: Give the owner the proposed matrix. Each row names an OS version, edition,
architecture and update level (bare or updated SP1 for Windows 7), and the environment that will
test it (physical machine or virtual machine). The owner can approve or change each row.

**Acceptance Scenarios**:

1. **Given** the proposed matrix, **When** the owner reviews it, **Then** it contains Windows 7
   SP1 x86 and x64, each in a bare-SP1 and an updated-SP1 state, plus Windows 10 x86 and x64 and
   Windows 11 x64.
2. **Given** an approved matrix, **When** a row has no available test environment, **Then** that
   row is marked blocked, names the missing environment and the related Phase 0 risk, and no
   compatibility is claimed for it.

---

### User Story 2 - Candidate technology is proven on Windows 7 SP1 (Priority: P1)

A tester follows written procedures on each approved environment and records, for each check,
pass or fail with evidence: the runtime installs offline, a test program starts, it creates,
writes, reads and reopens a local database, and the database survives an interrupted write.

**Why this priority**: This is the phase's core purpose. If the candidate cannot run on Windows 7
SP1 x86 and x64 without internet, every later phase is built on the wrong foundation.

**Independent Test**: On a clean Windows 7 SP1 machine with networking disabled, run the
procedure from installation through database checks and compare the recorded results with the
expected results.

**Acceptance Scenarios**:

1. **Given** a clean bare-SP1 environment with no network, **When** the tester installs from the
   offline package, **Then** every required runtime component installs or is reported missing with
   a clear message, and the result is recorded.
2. **Given** the installed runtime, **When** the tester runs the database tests, **Then** data
   written before a forced termination is either fully present or fully absent after restart, and
   the database passes its integrity check.
3. **Given** a failed check, **When** results are recorded, **Then** the failure, environment and
   reproduction steps are documented and the check is not reported as passed.

---

### User Story 3 - Arabic interface, scanner and printers work on target hardware (Priority: P1)

A tester checks that Arabic right-to-left screens render correctly, that a USB barcode scanner
adds items reliably, and that 80mm thermal receipts and A4 pages print Arabic text correctly and
open the cash drawer where supported.

**Why this priority**: Arabic RTL, scanning and 80mm/A4 printing are constitution requirements
(Article IV) and known risks (R-04, R-24). A stack that cannot print Arabic receipts or read
scans reliably is not viable.

**Independent Test**: Using the owner-provided scanner and printers, run the scanning and
printing procedures on at least one Windows 7 SP1 environment and inspect the screen and the
physical printouts against reference images.

**Acceptance Scenarios**:

1. **Given** an Arabic screen with mixed Arabic, Latin and numeric text, **When** it is shown,
   **Then** text is joined and ordered correctly right-to-left, numbers and EGP amounts read
   correctly, and nothing is clipped.
2. **Given** the scanner and the scanner test's input field, **When** a series of codes is scanned
   with the Arabic keyboard layout active, **Then** every code arrives complete and correct and
   each is accepted without manual focus changes.
3. **Given** an 80mm thermal printer and an A4 printer installed through their Windows drivers,
   **When** the reference receipt and reference page are printed, **Then** Arabic text, numbers and
   alignment match the reference, and a cash sale test opens a connected drawer where the printer
   supports it.

---

### User Story 4 - Performance is measured on a low-spec machine and targets are approved (Priority: P2)

The owner receives measured startup time, memory use and response times from a representative
2–4 GB RAM machine with a realistic data volume, proposes or accepts target values, and those
targets become binding for later phases.

**Why this priority**: Article II requires practicality on 2–4 GB machines; Phase 0 deferred the
measurable targets to this phase (FR-013, risk register §3). It is P2 because it depends on a
working runtime and database (Story 2) and on a low-spec machine that is not yet confirmed
(R-22).

**Independent Test**: Run the measurement procedure three times on the low-spec machine and
confirm each result is within 15% of the three-run average (FR-060a) and is recorded with the
machine's specification.

**Acceptance Scenarios**:

1. **Given** the low-spec machine and the synthetic dataset, **When** the measurement procedure
   runs, **Then** startup time, memory use while idle and under load, scan-to-line time, and
   database query and write times are recorded.
2. **Given** the measurements, **When** the owner approves target values, **Then** the targets
   are recorded with the measurement each is based on.

---

### User Story 5 - Offline install, upgrade and uninstall are proven (Priority: P2)

A tester installs, upgrades and uninstalls a minimal test package from local media only, and
confirms that
upgrade and uninstall never lose local data.

**Why this priority**: Article I requires fully offline installation; Phase 10 builds the product
installer on what this phase proves.

**Independent Test**: With networking disabled, install version A, create data, upgrade to
version B, confirm the data, uninstall, and confirm the data is still on disk.

**Acceptance Scenarios**:

1. **Given** no network, **When** the package is installed, upgraded and uninstalled, **Then** each
   step completes from local media alone.
2. **Given** existing local data, **When** the test package is upgraded or uninstalled, **Then**
   the
   data remains intact and readable.

---

### User Story 6 - Owner receives a compatibility decision (Priority: P1)

At the end of the phase, the owner receives one decision record: keep the candidate stack, keep it
with stated conditions (for example required prerequisites), or change it. Any change is presented
with the problem, alternatives, compatibility impact, effects and required tests, and is not
adopted without owner approval.

**Why this priority**: The PROJECT_PLAN.md acceptance criterion for Phase 1 is "a documented
compatibility decision backed by reproducible tests", and Article XII governs any change.

**Independent Test**: The decision record links every claim to a test result in the evidence set,
and re-running the evidence scripts on a second occasion reproduces a sample of results.

**Acceptance Scenarios**:

1. **Given** all results, **When** the decision record is written, **Then** each matrix row is
   marked supported, supported with conditions, not supported, or blocked, with evidence links.
2. **Given** a recommended technology change, **When** it is presented, **Then** it contains the
   five items required by Article XII and states that it awaits owner approval.

---

### Edge Cases

- **No Windows 7 SP1 environment is available** (R-01): procedures and tests may be prepared and
  run on other environments; no Windows 7 result is claimed and full Phase 1 acceptance stays
  blocked (Phase 2 may still start under FR-071).
- **No Windows 10 x86 environment is available**: M-06 tests are marked Blocked, no Windows 10
  x86 support is claimed, the limitation is documented, and no machine is bought for it (FR-001b).
- **A dependency installs only after Windows updates absent from bare SP1** (R-23): the finding is
  recorded with the exact prerequisite; the decision states whether it can be bundled offline or
  must be listed as a documented installation requirement.
- **Signature or certificate checks fail on bare SP1** when installing runtime components: the
  failure is recorded and its offline workaround, if any, is documented and tested.
- **The scanner is used while the Arabic keyboard layout is active**: letters in codes may arrive
  as Arabic characters; this is tested explicitly and its result recorded.
- **The scanner sends codes faster than the screen updates** or a code arrives while focus is
  elsewhere: no character is lost, duplicated or sent to another field.
- **The thermal printer cannot render Arabic text through its driver**: an alternative printing
  method is tested and recorded (R-04); untested printer models are not claimed as supported.
- **Power loss or forced termination during a database write**: no partial data remains after
  restart and the database passes its integrity check.
- **The disk holding the data is full or read-only**: the test reports a clear error and does
  not corrupt existing data.
- **The user runs without administrator rights**: daily operation works; only installation and
  uninstallation may require administrator rights.
- **Machine date is wrong or moves backwards**: recorded as an observation for Phase 2 (R-14); not
  a Phase 1 pass/fail check.

## Requirements *(mandatory)*

### Scope and Deliverables

- **FR-001**: Phase 1 MUST produce a proposed compatibility matrix listing every supported Windows
  version, edition, architecture and update level, with the test environment for each row; the
  matrix MUST be approved by the owner before final acceptance tests run (Phase 0 FR-012, R-21).
  The supported versions and architectures are Windows 7 SP1 x86 and x64, Windows 10 x86 and
  x64, and Windows 11 x64 (owner answer 2026-10-10, resolving Phase 0 D-01(a)); Windows 8.1 and
  Windows 11 on other architectures are not supported. The editions and update levels to test
  for each are proposed in the matrix for owner approval.
- **FR-001a**: Compatibility matrix (status: **Approved by the owner on 2026-10-10**).
  Editions are chosen for practical availability of licensed install media and test machines;
  an edition not listed is not claimed as supported unless the owner adds a row and it passes.

  | Row | Windows version and edition | Arch. | Update level | Test environment |
  |-----|-----------------------------|-------|--------------|------------------|
  | M-01 | Windows 7 Professional SP1 | x86 | Bare SP1 | Licensed virtual machine or physical PC |
  | M-02 | Windows 7 Professional SP1 | x86 | Updated SP1 | Licensed virtual machine or physical PC |
  | M-03 | Windows 7 Professional SP1 | x64 | Bare SP1 | Licensed virtual machine or physical PC |
  | M-04 | Windows 7 Professional SP1 | x64 | Updated SP1 | Licensed virtual machine or physical PC |
  | M-05 | Windows 10 Pro, version 22H2 | x64 | Fully updated | Physical PC or licensed virtual machine |
  | M-06 | Windows 10 Pro, version 22H2 | x86 | Fully updated | Licensed virtual machine or physical PC if available; otherwise Blocked (FR-001b) |
  | M-07 | Windows 11 Pro, latest generally available version at test time (recorded) | x64 | Fully updated | Physical PC or licensed virtual machine |

  Professional editions are proposed because licensed media and business PCs with them are the
  most practical to obtain; Home editions share the same runtime base but are not claimed until
  tested. Windows 10 version 22H2 is the final Windows 10 release. Performance (FR-060) is
  measured separately on the physical 2–4 GB RAM PC, whatever matrix version it runs, and that
  version is recorded.
- **FR-001b**: Phase 1 MUST NOT require buying a Windows 10 x86 machine. If no Windows 10 x86
  environment is available, every M-06 test MUST be marked Blocked, no Windows 10 x86 support MAY
  be claimed, and the decision record MUST document the limitation and the risk that 32-bit
  Windows 10 pharmacy PCs remain unverified. A Blocked M-06 does not by itself prevent Phase 1
  acceptance (FR-070).
- **FR-002**: Phase 1 MUST provide a repeatable procedure for every check in FR-010 to FR-062,
  run by the owner. Every check that can be automated (for example environment details, runtime
  and database checks, installation, upgrade and uninstall, network monitoring and performance
  measurement) MUST be a script that runs offline and writes its own evidence (FR-003). Checks
  that need a person (scanning, inspecting screens and printouts, the cash drawer) MUST be short
  written procedures with expected results and a pass/fail form. Each procedure MUST be usable by
  the owner without programming knowledge.
- **FR-003**: Phase 1 MUST produce an evidence set: for every check on every environment, the
  date, tester, environment details (OS version and build, edition, architecture, installed
  updates, RAM, CPU), result (pass, fail or blocked) and supporting artefacts (logs, screenshots,
  photographs or scans of printouts, measurements).
- **FR-004**: Phase 1 MUST produce a compatibility decision record (see User Story 6) that links
  every claim to evidence.
- **FR-005**: Phase 1 MUST validate compatibility directly through focused validation tests
  (technology, installation, scanner, printer and performance), each exercising one area with the
  smallest program, script or package that area needs; a test MAY use a minimal window (for
  example for Arabic screens, scanning or printing) or a minimal install package (for
  installation, upgrade and uninstall). Phase 1 MUST NOT build a standalone prototype or a
  combined demo application, and MUST NOT implement pharmacy business features.
  Validation tests are kept as evidence and are not shipped.
- **FR-006**: Phase 1 MUST record an updated status for each related Phase 0 risk (R-01, R-02,
  R-03, R-04, R-21, R-22, R-23, R-24) in its own deliverables, without editing the approved
  Phase 0 documents. It MUST also record any new limitation it finds, including an unavailable
  Windows 10 x86 environment (FR-001b).

### Candidate Technology (owner decision D-02)

- **FR-007**: The candidate technologies to validate first are the ones the owner approved in
  Phase 0 FR-016: C# Windows Forms, .NET Framework 4.8, SQLite and an offline installer containing
  all required dependencies. Dependencies SHOULD be free and commercially compatible; each
  dependency's licence MUST be recorded.
- **FR-008**: If any candidate fails a check, Phase 1 MUST document the problem, alternatives,
  Windows 7 and 32-bit implications, effects on data, security, performance, maintainability and
  delivery, and required tests (Article XII), and MUST NOT adopt the alternative without explicit
  owner approval.

### Runtime and Database Compatibility

- **FR-010**: On every matrix row, every runtime component the candidate needs MUST install from
  local media with no network connection, or the decision record MUST name the missing
  prerequisite and how it is provided offline.
- **FR-011**: A program built on the candidate runtime MUST start on every matrix row with no
  network connection.
- **FR-012**: The database tests MUST create a local database, write, read, update and reopen it after
  restart on every matrix row, in both 32-bit and 64-bit Windows 7 SP1.
- **FR-013**: A write that is interrupted by forced termination MUST leave the database either
  fully before or fully after the write, and the database MUST pass its integrity check after
  restart (Article III).
- **FR-014**: The runtime, database and device tests MUST pass under a standard
  (non-administrator) Windows account, as everyday operation will; local data MUST be stored where a standard user can write it.
- **FR-015**: During every test session, no test program or installer may make an outbound
  network attempt
  (Article I).

### Arabic Right-to-Left Interface

- **FR-020**: The Arabic interface test MUST show representative Arabic right-to-left screens (a form, a list,
  a dialog and an error message) that render correctly on every matrix row: correct letter joining,
  right-to-left order, correct placement of numbers, Latin text and EGP amounts, and no clipped
  text.
- **FR-021**: Arabic text entry by keyboard MUST work in the Arabic interface test's input
  fields.
- **FR-022**: The fonts used MUST be available on every matrix row without internet download, or
  be bundled with a licence that allows redistribution.

### Barcode Scanning

- **FR-030**: USB keyboard-style scanners that send Enter after each code (Phase 0 FR-096a) MUST
  be validated: every scanned code reaches the scan field complete, in order, and is accepted on
  Enter without manual focus changes.
- **FR-031**: Scanning MUST be tested with both the English and the Arabic keyboard layout active;
  the result for codes containing letters and for numeric codes MUST be recorded, and any
  required mitigation documented.
- **FR-032**: Rapid consecutive scans MUST NOT lose, duplicate or misroute characters.

### Printing and Cash Drawer

- **FR-040**: The printer test MUST print a reference Arabic receipt on each owner-provided 80mm
  thermal printer through its Windows driver (Phase 0 FR-096b) with correct Arabic text, numbers,
  alignment and paper cut where supported.
- **FR-041**: The printer test MUST print a reference Arabic A4 page (a table with totals, multiple
  pages) on each owner-provided A4 printer through its Windows driver.
- **FR-042**: If a thermal printer cannot print Arabic correctly through its driver, an
  alternative method MUST be tested and recorded (R-04); untested models MUST NOT be claimed as
  supported.
- **FR-043**: Where the owner provides a cash drawer connected to a receipt printer, the
  printer test MUST open it on a simulated cash sale and MUST NOT open it on a simulated non-cash
  sale (Phase 0 FR-096d).
- **FR-044**: Printing MUST report a clear error when the printer is offline, out of paper or
  missing, without the test program freezing.

### Installation, Upgrade and Uninstallation

- **FR-050**: A minimal test package containing the candidate runtime and database components
  MUST install, upgrade (from an earlier test package version) and uninstall from local media
  only on every matrix row (Article I).
- **FR-051**: Upgrade and uninstall MUST NOT delete or alter local data; uninstall MUST leave the
  data in place unless the user explicitly chooses to remove it after a clear warning.
- **FR-052**: Installation MUST state clearly when administrator rights are required.

### Performance on Low-Spec Hardware

- **FR-060**: Phase 1 MUST measure, on a physical 2–4 GB RAM machine running Windows 7 SP1
  (R-22): cold and warm startup time, memory use when idle and during a scan-and-print sequence,
  time from scan to item shown, and representative database search and write times. Virtual
  machines alone MUST NOT be used as performance evidence.
- **FR-061**: Measurements MUST use a synthetic test dataset of realistic size, labelled as test
  data, never shipped and never presented as catalog data (Phase 0 FR-007, FR-059).
- **FR-060a**: Each FR-060 metric MUST be measured in a set of three runs. The set is valid only
  if every run is within 15% of the set's average; otherwise the set MUST be repeated, and the
  discarded set MUST be kept in the evidence with the suspected cause. The average of the valid
  set is the measured value.
- **FR-062**: Phase 1 MUST propose target values for each FR-060 metric, based on the
  measurements; the owner's approved targets become acceptance criteria for later phases
  (Phase 0 FR-013).

### Phase Acceptance

- **FR-070**: Phase 1 acceptance requires: an owner-approved matrix; every matrix row tested or
  explicitly blocked; scanner and printer checks on at least one Windows 7 SP1 environment with
  owner-provided hardware; owner-approved performance targets; and an owner-approved
  compatibility decision.
- **FR-071**: While required test environments or hardware are unavailable (R-01, R-22, R-24),
  Phase 2 MAY start once every validation test that is possible on the available environments has
  passed and the owner approves the transition. Phase 1 MUST then record, for each unavailable
  environment or device, the open risk, the tests still to run and the Phase 2 decisions they
  could affect. Full Phase 1 acceptance (FR-070) still requires those tests. If a later Windows 7
  or hardware test reveals an incompatibility, the affected Phase 2 architecture MUST be revisited
  under Article XII before implementation continues.

### Key Entities

- **Compatibility matrix row**: a Windows version, edition, architecture and update level; its
  test environment (physical or virtual); its status (pending, supported, supported with
  conditions, not supported, blocked) and evidence links.
- **Test procedure**: a numbered check with purpose, preconditions, steps and expected result,
  linked to the requirement it verifies.
- **Test result**: one run of a procedure on one environment: date, tester, environment details,
  outcome and artefacts.
- **Validation test**: a focused, single-area test (runtime and database, Arabic interface,
  scanner, printer, installation or performance) with the smallest program, script or package that
  area needs; it is not a standalone or combined demo application, has no pharmacy business logic
  and is never shipped.
- **Synthetic test dataset**: generated, clearly labelled test data of realistic size used for
  measurements; never shipped.
- **Performance target**: a metric, its approved value, the measurement it is based on and the
  machine specification.
- **Compatibility decision record**: the final decision, conditions, rejected alternatives,
  dependency licences, risk status updates and owner approval.
- **Technology change proposal**: the five Article XII items for any proposed change, and its
  approval state.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of rows in the owner-approved matrix have a recorded status (supported,
  supported with conditions, not supported or blocked) backed by evidence.
- **SC-002**: Windows 7 SP1 x86 and x64, each in bare and updated state, are tested end to end
  (install, start, database, Arabic screens, uninstall) with no network connection, or the phase
  remains not accepted.
- **SC-003**: Re-running the evidence scripts on a second occasion reproduces the outcomes of
  at least 3 sampled automated checks per Windows 7 environment.
- **SC-004**: 500 consecutive scans, half with the Arabic keyboard layout active, give 0 lost,
  duplicated or misrouted codes, or the failure and its mitigation are recorded.
- **SC-005**: 20 consecutive reference receipts and 5 reference A4 pages per tested printer match
  the reference with no Arabic rendering errors, or the printer is recorded as not supported.
- **SC-006**: In 20 forced terminations during database writes, 100% leave the database
  consistent and passing its integrity check.
- **SC-007**: Network monitoring shows 0 outbound connection attempts by any test program or
  installer across all test sessions.
- **SC-008**: Each performance metric has a valid set of 3 runs on the low-spec machine, every
  run within 15% of the set average, and every approved target is recorded with its measurement.
- **SC-009**: After upgrade and after uninstall, 100% of the test data written before is still
  present and readable.
- **SC-010**: The owner approves the matrix, the performance targets and the compatibility
  decision, each with a recorded date.

## Assumptions

- **Technology names in this spec**: unlike a normal feature spec, Phase 1 exists to validate a
  named technology stack, so FR-007 names the owner-approved candidates (Phase 0 D-02). All other
  requirements describe outcomes, not implementation.
- Licensed Windows 7 SP1 virtual machines are acceptable for OS compatibility checks (Phase 0
  R-01), but not for performance evidence (R-22) or for hardware checks that need physical USB or
  printer access unless the device is passed through and the result is recorded as such.
- "Updated SP1" means Windows 7 SP1 with all updates that were publicly released for it; "bare
  SP1" means SP1 with no later updates. The exact update list of each test image is recorded.
- The owner provides the scanner, the 80mm thermal printer, the A4 printer and, if used, the cash
  drawer (R-24). Until then, those checks are blocked, not failed.
- The synthetic dataset size defaults to a busy single pharmacy over several years (for example,
  tens of thousands of products and hundreds of thousands of sale lines); the plan fixes the
  numbers and the owner may adjust them.
- Arabic digit style (Arabic-Indic or Western digits) is a Phase 3 interface decision; Phase 1
  verifies that both render correctly.
- Detailed receipt layout, the permission model and business rules belong to later phases; the
  reference receipt and page exist only to test rendering.
- Windows 7 security limitations remain as recorded in Phase 0 (R-13); passing Phase 1 is not a
  security claim (Article II).
