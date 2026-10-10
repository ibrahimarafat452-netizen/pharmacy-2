# Pharmacy Management System — Phase 0 run plan

Source: `PROJECT_PLAN.md`, Phase 0, run on its own (one phase per engine run).
Governing authority: `.specify/memory/constitution.md` v1.0.1 (ratified 2026-10-10).

## Gates
- `pwsh -NoProfile -File .specify/phase-plans/phase-00-gate.ps1`

## Phase 0: Requirements Review and Risk Closure

Goal: Resolve ambiguities before expensive implementation.

Deliverables:
- Reviewed requirements and explicit non-goals.
- Prioritized functional requirements and acceptance criteria.
- Risk register and unresolved decisions.
- Constitution compliance checklist.

Run instructions for this phase:
- Read `PROJECT_PLAN.md` in full (sections 1, 2, 4, 6 and all phases) and the constitution before
  writing anything. This phase produces documents only. Do not write application code.
- Put all deliverables in the Spec-Kit feature directory created by the specify step:
  `spec.md` (reviewed requirements, explicit non-goals, prioritized functional requirements,
  acceptance criteria), `risk-register.md` (risks and unresolved decisions) and
  `constitution-checklist.md` (one entry per constitution Article I–XIII).
- Every open decision listed in section 6 of `PROJECT_PLAN.md` that is not already settled by the
  constitution MUST appear as its own `[NEEDS CLARIFICATION: ...]` marker in `spec.md`. This
  overrides the specify skill's usual limit of 3 markers. Group related decisions together. Do not
  assume answers, and do not ask about details that a later phase's specification can safely decide.
- Already known, to be recorded in `risk-register.md`: no Windows 7 SP1 test environment
  (x86 or x64) is available yet. Phase 1's acceptance criteria cannot pass until one exists.
- Do not fabricate catalog data, legal requirements or business rules.

Acceptance criteria:
- No critical business rule remains ambiguous.
- The owner approves the scope and high-impact decisions.
