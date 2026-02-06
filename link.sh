#!/bin/bash

export REPO="bobgit18/finops-cost-recom-engine"

echo "----------------------------------------"
echo " LINKING: Epic → Features → Stories → Tasks → Sub‑tasks"
echo "----------------------------------------"

if ! gh auth status >/dev/null 2>&1; then
  echo "ERROR: gh auth status failed — please authenticate with 'gh auth login'"
  exit 1
fi

if ! gh repo view "$REPO" >/dev/null 2>&1; then
  echo "ERROR: repository not found or access denied: $REPO"
  exit 1
fi

###############################################################################
# 1. FETCH ALL ISSUES BY LABEL
###############################################################################

EPIC=$(gh issue list --repo "$REPO" --label epic --limit 1 --json number --jq '.[0].number' 2>/dev/null)
if [ -z "$EPIC" ] || [ "$EPIC" = "null" ]; then
  echo "WARN: no issues found with label 'epic' in $REPO"
  EPIC=""
fi

declare -A FEATURES
declare -A STORIES
declare -A TASKS
declare -A SUBTASKS

# Load Features (use JSON output + jq for robust parsing)
while IFS=$'\t' read -r num title; do
  FEATURES["$title"]="$num"
done < <(gh issue list --repo "$REPO" --label feature --limit 100 --json number,title 2>/dev/null | jq -r '.[] | "\(.number)\t\(.title)"')

# Load Stories
while IFS=$'\t' read -r num title; do
  STORIES["$title"]="$num"
done < <(gh issue list --repo "$REPO" --label story --limit 100 --json number,title 2>/dev/null | jq -r '.[] | "\(.number)\t\(.title)"')

# Load Tasks
while IFS=$'\t' read -r num title; do
  TASKS["$title"]="$num"
done < <(gh issue list --repo "$REPO" --label task --limit 100 --json number,title 2>/dev/null | jq -r '.[] | "\(.number)\t\(.title)"')

# Load Sub‑tasks
while IFS=$'\t' read -r num title; do
  SUBTASKS["$title"]="$num"
done < <(gh issue list --repo "$REPO" --label subtask --limit 100 --json number,title 2>/dev/null | jq -r '.[] | "\(.number)\t\(.title)"')

echo "Epic: #$EPIC"
echo "Features: ${FEATURES[@]}"
echo "Stories: ${STORIES[@]}"
echo "Tasks: ${TASKS[@]}"
echo "Sub‑tasks: ${SUBTASKS[@]}"
echo ""

# Helper: append text to an issue body using gh api + jq (compatible across gh versions)
append_issue_body() {
  local ISSUE_NUM="$1"
  local APPEND_TEXT="$2"
  existing_body=$(gh api "/repos/$REPO/issues/$ISSUE_NUM" 2>/dev/null | jq -r '.body // ""')
  new_body="$existing_body\n$APPEND_TEXT"
  gh api --silent -X PATCH "/repos/$REPO/issues/$ISSUE_NUM" -F body="$new_body" >/dev/null
}

###############################################################################
# 2. DEFINE HIERARCHY MAPPINGS
###############################################################################

# Feature → Epic
declare -A FEATURE_TO_EPIC
for F in "${!FEATURES[@]}"; do
  FEATURE_TO_EPIC["$F"]=$EPIC
done

# Story → Feature
declare -A STORY_TO_FEATURE
STORY_TO_FEATURE["Story: Ingest Azure Cost Export Data"]="Feature: Ingest and Normalise Cloud Cost Data"
STORY_TO_FEATURE["Story: Normalise Cost & Usage Data"]="Feature: Ingest and Normalise Cloud Cost Data"
STORY_TO_FEATURE["Story: Rightsizing Recommendations"]="Feature: Rule-Based FinOps Recommendations"
STORY_TO_FEATURE["Story: Idle Resource Detection"]="Feature: Rule-Based FinOps Recommendations"
STORY_TO_FEATURE["Story: Storage Tiering Recommendations"]="Feature: Rule-Based FinOps Recommendations"
STORY_TO_FEATURE["Story: Reserved Instance Opportunities"]="Feature: Rule-Based FinOps Recommendations"
STORY_TO_FEATURE["Story: Cost Anomaly Detection"]="Feature: ML-Based Anomaly Detection"
STORY_TO_FEATURE["Story: Cost Forecasting"]="Feature: ML-Based Anomaly Detection"
STORY_TO_FEATURE["Story: JSON Output for API Integration"]="Feature: Reporting & Output Layer"
STORY_TO_FEATURE["Story: Markdown Report for Stakeholders"]="Feature: Reporting & Output Layer"
STORY_TO_FEATURE["Story: Validate Recommendations Against FinOps Best Practices"]="Feature: Evaluation & Validation Framework"
STORY_TO_FEATURE["Story: UI to View Recommendations"]="Feature: UI Layer (Streamlit Dashboard)"

# Task → Story
declare -A TASK_TO_STORY
TASK_TO_STORY["Task: Implement Azure Cost Export Ingestion"]="Story: Ingest Azure Cost Export Data"
TASK_TO_STORY["Task: Parse Resource Metadata"]="Story: Ingest Azure Cost Export Data"
TASK_TO_STORY["Task: Validate Ingestion with Sample Dataset"]="Story: Ingest Azure Cost Export Data"
TASK_TO_STORY["Task: Build Normalisation Pipeline"]="Story: Normalise Cost & Usage Data"
TASK_TO_STORY["Task: Map Services to Standard Taxonomy"]="Story: Normalise Cost & Usage Data"
TASK_TO_STORY["Task: Implement Utilisation Extraction Logic"]="Story: Rightsizing Recommendations"
TASK_TO_STORY["Task: Build Rightsizing Rule Engine"]="Story: Rightsizing Recommendations"
TASK_TO_STORY["Task: Write Unit Tests for Rightsizing"]="Story: Rightsizing Recommendations"
TASK_TO_STORY["Task: Identify Idle Resource Signals"]="Story: Idle Resource Detection"
TASK_TO_STORY["Task: Build Idle Resource Rule"]="Story: Idle Resource Detection"
TASK_TO_STORY["Task: Map Storage Tiers"]="Story: Storage Tiering Recommendations"
TASK_TO_STORY["Task: Build Storage Tiering Rule"]="Story: Storage Tiering Recommendations"
TASK_TO_STORY["Task: Identify RI Opportunities"]="Story: Reserved Instance Opportunities"
TASK_TO_STORY["Task: Build RI Recommendation Logic"]="Story: Reserved Instance Opportunities"
TASK_TO_STORY["Task: Implement Isolation Forest Model"]="Story: Cost Anomaly Detection"
TASK_TO_STORY["Task: Build Forecasting Model"]="Story: Cost Forecasting"
TASK_TO_STORY["Task: Evaluate Forecasting Accuracy"]="Story: Cost Forecasting"
TASK_TO_STORY["Task: Build JSON Output Generator"]="Story: JSON Output for API Integration"
TASK_TO_STORY["Task: Build Markdown Report Template"]="Story: Markdown Report for Stakeholders"
TASK_TO_STORY["Task: Add Recommendation Severity Scoring"]="Story: Markdown Report for Stakeholders"
TASK_TO_STORY["Task: Build Validation Harness"]="Story: Validate Recommendations Against FinOps Best Practices"
TASK_TO_STORY["Task: Create Test Datasets"]="Story: Validate Recommendations Against FinOps Best Practices"
TASK_TO_STORY["Task: Add Rule Coverage Metrics"]="Story: Validate Recommendations Against FinOps Best Practices"
TASK_TO_STORY["Task: Build Streamlit Dashboard"]="Story: UI to View Recommendations"
TASK_TO_STORY["Task: Add Filters"]="Story: UI to View Recommendations"
TASK_TO_STORY["Task: Add Charts"]="Story: UI to View Recommendations"

# Sub‑task → Task
declare -A SUBTASK_TO_TASK
SUBTASK_TO_TASK["Sub-task: Extract VM SKU Metadata"]="Task: Implement Azure Cost Export Ingestion"
SUBTASK_TO_TASK["Sub-task: Clean Malformed Cost Rows"]="Task: Implement Azure Cost Export Ingestion"
SUBTASK_TO_TASK["Sub-task: Implement Currency Normalisation"]="Task: Build Normalisation Pipeline"
SUBTASK_TO_TASK["Sub-task: Compute Utilisation Ratio"]="Task: Implement Utilisation Extraction Logic"
SUBTASK_TO_TASK["Sub-task: Generate Rightsizing Evidence"]="Task: Build Rightsizing Rule Engine"
SUBTASK_TO_TASK["Sub-task: Identify Idle Metrics"]="Task: Identify Idle Resource Signals"
SUBTASK_TO_TASK["Sub-task: Implement Idle Rule Logic"]="Task: Build Idle Resource Rule"
SUBTASK_TO_TASK["Sub-task: Analyse Storage Access Patterns"]="Task: Map Storage Tiers"
SUBTASK_TO_TASK["Sub-task: Implement Tiering Logic"]="Task: Build Storage Tiering Rule"
SUBTASK_TO_TASK["Sub-task: Collect RI Usage Data"]="Task: Identify RI Opportunities"
SUBTASK_TO_TASK["Sub-task: Calculate RI Savings"]="Task: Build RI Recommendation Logic"
SUBTASK_TO_TASK["Sub-task: Train Isolation Forest"]="Task: Implement Isolation Forest Model"
SUBTASK_TO_TASK["Sub-task: Tune Anomaly Thresholds"]="Task: Implement Isolation Forest Model"
SUBTASK_TO_TASK["Sub-task: Prepare Training Data"]="Task: Build Forecasting Model"
SUBTASK_TO_TASK["Sub-task: Evaluate Forecast Accuracy"]="Task: Evaluate Forecasting Accuracy"
SUBTASK_TO_TASK["Sub-task: Generate JSON Schema"]="Task: Build JSON Output Generator"
SUBTASK_TO_TASK["Sub-task: Write Markdown Sections"]="Task: Build Markdown Report Template"
SUBTASK_TO_TASK["Sub-task: Implement Severity Scoring"]="Task: Add Recommendation Severity Scoring"
SUBTASK_TO_TASK["Sub-task: Build Validation Scripts"]="Task: Build Validation Harness"
SUBTASK_TO_TASK["Sub-task: Create Synthetic Test Data"]="Task: Create Test Datasets"
SUBTASK_TO_TASK["Sub-task: Compute Rule Coverage"]="Task: Add Rule Coverage Metrics"
SUBTASK_TO_TASK["Sub-task: Implement Dashboard Layout"]="Task: Build Streamlit Dashboard"
SUBTASK_TO_TASK["Sub-task: Add Filter Widgets"]="Task: Add Filters"
SUBTASK_TO_TASK["Sub-task: Add Cost Charts"]="Task: Add Charts"

###############################################################################
# 3. UPDATE ISSUE BODIES WITH LINKS
###############################################################################

echo ""
echo "Linking Features → Epic..."

for F in "${!FEATURES[@]}"; do
  FNUM="${FEATURES[$F]}"
  append_issue_body "$FNUM" "**Parent Epic:** #$EPIC"
done

echo ""
echo "Linking Stories → Features..."

for STORY in "${!STORY_TO_FEATURE[@]}"; do
  SNUM="${STORIES[$STORY]}"
  PF="${STORY_TO_FEATURE[$STORY]}"
  FNUM="${FEATURES[$PF]}"
  append_issue_body "$SNUM" "**Parent Feature:** #$FNUM"
done

echo ""
echo "Linking Tasks → Stories..."

for TASK in "${!TASK_TO_STORY[@]}"; do
  TNUM="${TASKS[$TASK]}"
  PS="${TASK_TO_STORY[$TASK]}"
  SNUM="${STORIES[$PS]}"
  append_issue_body "$TNUM" "**Parent Story:** #$SNUM"
done

echo ""
echo "Linking Sub‑tasks → Tasks..."

for SUB in "${!SUBTASK_TO_TASK[@]}"; do
  STNUM="${SUBTASKS[$SUB]}"
  PT="${SUBTASK_TO_TASK[$SUB]}"
  TNUM="${TASKS[$PT]}"
  append_issue_body "$STNUM" "**Parent Task:** #$TNUM"
done

echo ""
echo "----------------------------------------"
echo " LINKING COMPLETE — All hierarchy references added"
echo "----------------------------------------"
