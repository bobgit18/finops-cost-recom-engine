#!/bin/bash

# Set your repository here
REPO="bobgit18/finops-cost-recom-engine"

# -----------------------------
# Sub‑tasks for Ingestion (S1)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Extract VM SKU Metadata" \
  --body "Parent Task: #T1" --label subtask

gh issue create --repo $REPO --title "Sub-task: Clean Malformed Cost Rows" \
  --body "Parent Task: #T1" --label subtask

gh issue create --repo $REPO --title "Sub-task: Implement Currency Normalisation" \
  --body "Parent Task: #T4" --label subtask

# -----------------------------
# Sub‑tasks for Rightsizing (S3)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Compute Utilisation Ratio" \
  --body "Parent Task: #T6" --label subtask

gh issue create --repo $REPO --title "Sub-task: Map SKU to Recommended Size" \
  --body "Parent Task: #T7" --label subtask

gh issue create --repo $REPO --title "Sub-task: Generate Rightsizing Recommendation Object" \
  --body "Parent Task: #T7" --label subtask

# -----------------------------
# Sub‑tasks for Idle Detection (S4)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Identify Zero-Utilisation Signals" \
  --body "Parent Task: #T9" --label subtask

gh issue create --repo $REPO --title "Sub-task: Build Idle Resource Flag Logic" \
  --body "Parent Task: #T10" --label subtask

# -----------------------------
# Sub‑tasks for Storage Tiering (S5)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Map Storage Access Patterns" \
  --body "Parent Task: #T11" --label subtask

gh issue create --repo $REPO --title "Sub-task: Build Tier Recommendation Logic" \
  --body "Parent Task: #T12" --label subtask

# -----------------------------
# Sub‑tasks for RI Opportunities (S6)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Analyse Consistent Usage Patterns" \
  --body "Parent Task: #T13" --label subtask

gh issue create --repo $REPO --title "Sub-task: Build RI/Savings Plan Mapping" \
  --body "Parent Task: #T14" --label subtask

# -----------------------------
# Sub‑tasks for Anomaly Detection (S7)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Prepare Historical Cost Dataset" \
  --body "Parent Task: #T15" --label subtask

gh issue create --repo $REPO --title "Sub-task: Tune Isolation Forest Parameters" \
  --body "Parent Task: #T15" --label subtask

# -----------------------------
# Sub‑tasks for Forecasting (S8)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Prepare Time-Series Data" \
  --body "Parent Task: #T16" --label subtask

gh issue create --repo $REPO --title "Sub-task: Evaluate Forecast Confidence Intervals" \
  --body "Parent Task: #T17" --label subtask

# -----------------------------
# Sub‑tasks for Reporting (S9, S10)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Format JSON Output Schema" \
  --body "Parent Task: #T18" --label subtask

gh issue create --repo $REPO --title "Sub-task: Build Markdown Summary Section" \
  --body "Parent Task: #T19" --label subtask

gh issue create --repo $REPO --title "Sub-task: Implement Severity Scoring Logic" \
  --body "Parent Task: #T20" --label subtask

# -----------------------------
# Sub‑tasks for Validation (S11)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Build Test Dataset Generator" \
  --body "Parent Task: #T22" --label subtask

gh issue create --repo $REPO --title "Sub-task: Implement Rule Coverage Metrics" \
  --body "Parent Task: #T23" --label subtask

# -----------------------------
# Sub‑tasks for UI (S12)
# -----------------------------
gh issue create --repo $REPO --title "Sub-task: Build Recommendation Table Component" \
  --body "Parent Task: #T24" --label subtask

gh issue create --repo $REPO --title "Sub-task: Add Filter UI Controls" \
  --body "Parent Task: #T25" --label subtask

gh issue create --repo $REPO --title "Sub-task: Add Cost Trend Charts" \
  --body "Parent Task: #T26" --label subtask
