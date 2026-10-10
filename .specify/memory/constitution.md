# Pharmacy Management System Constitution

**Product**: Offline Pharmacy Management System for Egypt

Keywords MUST, MUST NOT, SHOULD, and MAY are used in their RFC 2119 sense. A SHOULD may be
departed from only with a documented reason.

## Core Principles

### I. Offline-First Architecture

- The application MUST operate entirely offline during installation, activation, daily
  operation, reporting, backup, and restoration.
- No cloud services, external APIs, online activation, telemetry, or internet-dependent features
  may be required for core functionality.
- All pharmacy business data MUST be stored locally on the pharmacy computer.
- Installation packages MUST include all required dependencies or provide them through local
  installation media.
- GitHub may be used for source code management, but pharmacy databases, customer records,
  license secrets, and production backups MUST NOT be committed to source control.

Rationale: target pharmacies may have unreliable or no internet access, and their business data
must stay under their control.

### II. Legacy Windows Compatibility

- The product MUST target Windows 7 SP1, both 32-bit and 64-bit, as well as compatible newer
  Windows versions.
- The application MUST remain practical on low-resource computers with approximately 2–4 GB RAM.
- Technology and dependency choices MUST be validated against the actual operating system and
  processor architecture requirements.
- Performance MUST be evaluated using representative low-spec hardware and realistic pharmacy
  workloads.
- Compatibility claims MUST be supported by testing. Successful compilation on a modern computer
  is not sufficient evidence of compatibility.
- Windows 7 is a legacy operating system. Compatibility MUST NOT be presented as a guarantee of
  operating-system security.

Rationale: many target pharmacies run older, low-spec Windows machines; many modern runtimes no
longer support them.

### III. Data Integrity and Financial Accuracy

- Sales, purchases, returns, payments, expenses, debt movements, cash movements, and inventory
  adjustments MUST preserve financial and inventory consistency.
- Related business changes MUST be committed atomically whenever they form one business
  transaction.
- Failed operations MUST NOT leave partial sales, incorrect stock deductions, or inconsistent
  account balances.
- Posted financial transactions MUST NOT be silently edited or deleted. Corrections MUST use
  controlled, traceable reversal or adjustment procedures.
- Every inventory movement MUST have a traceable source, timestamp, and responsible user.
- The system MUST distinguish revenue, cost of goods sold, gross profit, operating expenses,
  estimated net profit, cash received, and outstanding debts.
- Credit sales MUST NOT be counted as cash received.
- Database backup and restoration MUST preserve transaction consistency and be tested before
  release.

Rationale: the system is the pharmacy's financial and stock record; inconsistent data causes real
monetary loss and disputes.

### IV. Simplicity and Professional User Experience

- Arabic with right-to-left layout MUST be the default user experience.
- The interface MUST be professional, consistent, readable, and appropriate for extended daily
  use.
- Routine operations MUST require as few steps as reasonably possible.
- Medicine registration MUST NOT require a manufacturer field.
- Medicine names MUST be easy to enter and may include strength, concentration, or dosage form
  without forcing users to complete unnecessary separate fields.
- The initial product scope MUST support selling packages and strips, not individual tablets.
- Package-to-strip conversion MUST be configurable per medicine and MUST NOT be assumed to be
  identical for every medicine.
- Barcode scanning MUST prioritize speed, accurate identification, and minimal keyboard or mouse
  interaction.
- The application MUST support common 80mm thermal receipt printers for point-of-sale receipts,
  in addition to standard A4 printing for reports.
- The application MUST avoid unnecessary animations and resource-intensive visual effects.
- Errors MUST explain what happened and how the user can recover.

Rationale: staff use the system all day at the counter; speed and clarity matter more than
visual effects.

### V. Security, Permissions, and Accountability

- The initial user roles MUST include Manager, Pharmacist, and Cashier, with permissions
  appropriate to their responsibilities.
- Sensitive actions, including authorized discounts, returns, price changes, inventory
  adjustments, cash corrections, user administration, and restoration, MUST be
  permission-controlled.
- The application MUST record relevant sensitive actions with the responsible user, timestamp,
  affected record, and reason where appropriate.
- Ordinary users MUST NOT be able to silently alter closed shifts or erase transaction history
  through normal application workflows.
- Passwords and other authentication secrets MUST NOT be stored in plaintext.
- Access control MUST be enforced in the application logic, not merely by hiding interface
  controls.

Rationale: several staff share one computer and handle cash; accountability deters and exposes
misuse.

### VI. Offline Licensing and Product Ownership

- The product MUST support local license validation without contacting an external server.
- The license system SHOULD bind each customer license to an authorized computer.
- License issuance MUST use a protected owner-controlled signing mechanism. Private signing keys
  MUST NOT be embedded in the application or distributed with customer builds.
- The product MUST provide a documented procedure for legitimate computer replacement and license
  recovery.
- License enforcement MUST NOT delete, encrypt, or intentionally destroy pharmacy data.
- The product MUST retain a safe, documented method for protecting and recovering customer data.
- The product MUST NOT be advertised as impossible to copy or crack.

Rationale: the owner's commercial rights must be protected without ever holding a customer's
data hostage.

### VII. Core Product and Customer-Specific Versions

- The owner MUST maintain a clean, independent original version of the product.
- Each customer-specific version MUST have a documented relationship to its originating core
  release.
- Customer-specific branding and custom code MUST remain isolated from other customers' versions.
- Customer changes MUST NOT be merged into the original product automatically.
- Common improvements SHOULD be reusable across customer versions through a documented review and
  integration process.
- Each release MUST identify its product version, source revision, and customer variant where
  applicable.
- Source repositories MUST NOT contain customer production databases, private license keys, or
  other sensitive production data.

Rationale: customized deliveries must not contaminate the core product or leak between
customers.

### VIII. Explainable Local Intelligence

- Purchase recommendations MUST operate locally using deterministic rules and available pharmacy
  data.
- The recommendation engine MAY consider historical sales, demand trends, seasonality when
  sufficient history exists, supplier lead time, safety stock, incoming orders, current
  inventory, expiry dates, and stagnant stock.
- Recommendations MUST explain the principal factors behind the suggested purchase quantity.
- Missing or insufficient historical data MUST be identified honestly rather than treated as
  reliable evidence.
- The system MUST account for expiry risk and avoid recommending unnecessary excess stock where
  reasonably possible.
- Recommendations MUST remain advisory. The pharmacist or authorized user retains control over
  purchasing decisions.
- The recommendation engine MUST NOT diagnose patients, prescribe treatment, or independently
  recommend changing prescribed medicines.

Rationale: a recommendation the pharmacist cannot understand cannot be trusted; clinical
decisions stay with qualified people.

### IX. Useful Reports and Cash Management

- Reports MUST support a defined operational, financial, or inventory-management decision.
- The system MUST support cash-drawer and shift management, including opening cash, recorded cash
  movements, expected closing cash, actual counted cash, variance, and handover.
- Cash movements MUST be distinguished from non-cash payments and credit transactions.
- The system MUST support configurable operating expense categories, including rent, salaries,
  utilities, maintenance, and other relevant expenses.
- Financial reports MUST use documented calculation rules and reconcile with underlying
  transactions.
- The system MUST provide proactive alerts for medicines approaching their expiry date, and a
  dedicated report listing near-expiry and stagnant (slow-moving) inventory, to support timely
  returns, discounting, or disposal decisions.
- Reports SHOULD include useful filters, printing, and practical export options compatible with
  supported operating systems.
- Redundant dashboards and reports without a clear business purpose SHOULD be avoided.

Rationale: reports exist to drive decisions; unreconciled or purposeless reports mislead.

### X. Backup, Recovery, and Availability

- The system MUST support automatic and manual backups.
- Backup destinations MUST be configurable, with a non-C drive preferred where available.
- Backup failures MUST be reported clearly. The application MUST NOT report success when a backup
  has failed.
- Backup procedures MUST use a database-safe mechanism.
- The system MUST support validation of backup integrity and restoration to a consistent state.
- Before restoration, the system MUST protect the current database or provide a verified recovery
  path.
- The interface MUST display the status and time of the last successful backup.
- Backup and restoration procedures MUST be tested on the supported deployment environments.

Rationale: a single local computer is a single point of failure; backups are the only protection
against data loss.

### XI. Engineering Quality and Verification

- Requirements and acceptance criteria MUST be defined before implementation of each feature.
- The project MUST use clear separation between user interface, business logic, persistence,
  reporting, backup, and licensing responsibilities where practical.
- Automated tests SHOULD cover financial calculations, stock conversion, debt balances, cash
  reconciliation, license validation, and purchase recommendations.
- Integration tests MUST cover critical workflows, including sales, purchases, returns, and
  backup restoration.
- Deployment tests MUST explicitly cover the supported Windows architectures.
- A feature MUST NOT be considered complete merely because its code compiles.
- Critical failures involving data loss, financial inconsistency, unauthorized access, or
  corrupted restoration MUST block release.
- Each release MUST include appropriate test evidence and documentation.

### XII. Controlled Technical Flexibility

- The project owner retains final authority over scope, architecture, commercial policy, and
  release decisions.
- The Coding Agent MAY identify problems and propose alternative technologies, dependencies, or
  designs.
- Before implementing a material change, the agent MUST document:
  1. The problem or limitation.
  2. The proposed change and available alternatives.
  3. Compatibility implications, especially for Windows 7 and 32-bit systems.
  4. Effects on existing data, security, performance, maintainability, and delivery.
  5. Required tests and migration or rollback steps.
- Material changes MUST NOT be implemented until the owner explicitly approves them.
- Routine implementation choices that remain within approved requirements MAY be made by the
  agent without additional approval.
- If a critical ambiguity or conflict is discovered, implementation of the affected feature MUST
  pause until the issue is resolved.

### XIII. Scope Discipline

- The initial release MUST target a single-computer pharmacy installation.
- Multi-computer LAN support, cloud synchronization, online activation, cloud AI, and electronic
  tax-invoice integration are outside the initial scope unless separately approved.
- The initial sales workflow MUST support package and strip sales, not individual-tablet sales.
- The printed receipt MUST be treated as an internal pharmacy receipt and MUST NOT automatically
  be represented as satisfying every applicable Egyptian tax or e-invoicing obligation.
- New features MUST have a clear operational, financial, security, or compliance benefit before
  being added to the approved scope.

## Document Status

- Status: Ratified.
- Approval status: Approved by the project owner on 2026-10-10.

## Changelog

- 1.0.1:
  - Article IV: added requirement for 80mm thermal receipt printer support alongside A4.
  - Article IX: added requirement for proactive expiry alerts and a near-expiry/stagnant-stock
    report.

## Governance

- This Constitution governs project specifications, implementation plans, code changes, and
  release decisions.
- Any conflict between a feature specification and this Constitution MUST be resolved before
  implementing the conflicting requirement.
- Amendments MUST include a documented reason and an assessment of their impact.
- Material amendments require explicit approval from the project owner.
- The approved Constitution MUST be maintained in version control and updated whenever an
  amendment is approved.
- Versioning follows semantic versioning: MAJOR for removing or redefining an article, MINOR for
  a new article or materially expanded guidance, PATCH for clarifications and wording.
- Every specification and implementation plan MUST include a Constitution Check against these
  articles before work proceeds.

**Version**: 1.0.1 | **Ratified**: 2026-10-10 | **Last Amended**: 2026-10-10
