#!/bin/bash

REPO="bobgit18/finops-cost-recom-engine"

echo "----------------------------------------"
echo " Creating EPIC "
echo "----------------------------------------"

EPIC=$(gh issue create --repo $REPO \
  --title "Epic: Build Cost-Aware FinOps Recommendation Engine" \
  --label epic \
  --body "Top-level initiative for the FinOps engine." | grep -oP '#\K[0-9]+')

echo "Epic created: #$EPIC"


echo "----------------------------------------"

echo "----------------------------------------"

declare -A FEATURES
FEATURE_LIST=(
  "Ingest and Normalise Cloud Cost Data"
  "Rule-Based FinOps Recommendations"
  "ML-Based Anomaly Detection"
  "Reporting & Output Layer"
  "Evaluation & Validation Framework"
  "UI Layer (Streamlit Dashboard)"
)

for F in "${FEATURE_LIST[@]}"; do
  FNUM=$(gh issue create --repo $REPO \
    --title "Feature: $F" \
    --label feature \
    --body "Parent Epic: #$EPIC" | grep -oP '#\K[0-9]+')
  FEATURES["$F"]=$FNUM
  echo "Feature created: #$FNUM ($F)"
done


echo "----------------------------------------"
echo " Creating STORIES "
echo "----------------------------------------"

declare -A STORIES
declare -A STORY_TO_FEATURE

STORY_TO_FEATURE["Ingest Azure Cost Export Data"]="Ingest and Normalise Cloud Cost Data"
STORY_TO_FEATURE["Normalise Cost & Usage Data"]="Ingest and Normalise Cloud Cost Data"

STORY_TO_FEATURE["Rightsizing Recommendations"]="Rule-Based FinOps Recommendations"
STORY_TO_FEATURE["Idle Resource Detection"]="Rule-Based FinOps Recommendations"
STORY_TO_FEATURE["Storage Tiering Recommendations"]="Rule-Based FinOps Recommendations"
STORY_TO_FEATURE["Reserved Instance Opportunities"]="Rule-Based FinOps Recommendations"

STORY_TO_FEATURE["Cost Anomaly Detection"]="ML-Based Anomaly Detection"
STORY_TO_FEATURE["Cost Forecasting"]="ML-Based Anomaly Detection"

STORY_TO_FEATURE["JSON Output for API Integration"]="Reporting & Output Layer"
STORY_TO_FEATURE["Markdown Report for Stakeholders"]="Reporting & Output Layer"

STORY_TO_FEATURE["Validate Recommendations Against FinOps Best Practices"]="Evaluation & Validation Framework"

STORY_TO_FEATURE["UI to View Recommendations"]="UI Layer (Streamlit Dashboard)"

for STORY in "${!STORY_TO_FEATURE[@]}"; do
  PF="${STORY_TO_FEATURE[$STORY]}"
  FNUM="${FEATURES[$PF]}"

  SNUM=$(gh issue create --repo $REPO \
    --title "Story: $STORY" \
    --label story \
    --body "Parent Feature: #$FNUM" | grep -oP '#\K[0-9]+')

  STORIES["$STORY"]=$SNUM
  echo "Story created: #$SNUM ($STORY)"
done


echo "----------------------------------------"
echo " Creating TASKS "
echo "----------------------------------------"

declare -A TASKS
declare -A TASK_TO_STORY

TASK_TO_STORY["Implement Azure Cost Export Ingestion"]="Ingest Azure Cost Export Data"
TASK_TO_STORY["Parse Resource Metadata"]="Ingest Azure Cost Export Data"
TASK_TO_STORY["Validate Ingestion with Sample Dataset"]="Ingest Azure Cost Export Data"

TASK_TO_STORY["Build Normalisation Pipeline"]="Normalise Cost & Usage Data"
TASK_TO_STORY["Map Services to Standard Taxonomy"]="Normalise Cost & Usage Data"

TASK_TO_STORY["Implement Utilisation Extraction Logic"]="Rightsizing Recommendations"
TASK_TO_STORY["Build Rightsizing Rule Engine"]="Rightsizing Recommendations"
TASK_TO_STORY["Write Unit Tests for Rightsizing"]="Rightsizing Recommendations"

TASK_TO_STORY["Identify Idle Resource Signals"]="Idle Resource Detection"
TASK_TO_STORY["Build Idle Resource Rule"]="Idle Resource Detection"

TASK_TO_STORY["Map Storage Tiers"]="Storage Tiering Recommendations"
TASK_TO_STORY["Build Storage Tiering Rule"]="Storage Tiering Recommendations"

TASK_TO_STORY["Identify RI Opportunities"]="Reserved Instance Opportunities"
TASK_TO_STORY["Build RI Recommendation Logic"]="Reserved Instance Opportunities"

TASK_TO_STORY["Implement Isolation Forest Model"]="Cost Anomaly Detection"

TASK_TO_STORY["Build Forecasting Model"]="Cost Forecasting"
TASK_TO_STORY["Evaluate Forecasting Accuracy"]="Cost Forecasting"

TASK_TO_STORY["Build JSON Output Generator"]="JSON Output for API Integration"

TASK_TO_STORY["Build Markdown Report Template"]="Markdown Report for Stakeholders"
TASK_TO_STORY["Add Recommendation Severity Scoring"]="Markdown Report for Stakeholders"

TASK_TO_STORY["Build Validation Harness"]="Validate Recommendations Against FinOps Best Practices"
TASK_TO_STORY["Create Test Datasets"]="Validate Recommendations Against FinOps Best Practices"
TASK_TO_STORY["Add Rule Coverage Metrics"]="Validate Recommendations Against FinOps Best Practices"

TASK_TO_STORY["Build Streamlit Dashboard"]="UI to View Recommendations"
TASK_TO_STORY["Add Filters"]="UI to View Recommendations"
TASK_TO_STORY["Add Charts"]="UI to View Recommendations"

for TASK in "${!TASK_TO_STORY[@]}"; do
  PS="${TASK_TO_STORY[$TASK]}"
  SNUM="${STORIES[$PS]}"

  TNUM=$(gh issue create --repo $REPO \
    --title "Task: $TASK" \
    --label task \
    --body "Parent Story: #$SNUM" | grep -oP '#\K[0-9]+')

  TASKS["$TASK"]=$TNUM
  echo "Task created: #$TNUM ($TASK)"
done


echo "----------------------------------------"
echo " Creating SUB‑TASKS "
echo "----------------------------------------"

declare -A SUBTASKS
declare -A SUBTASK_TO_TASK

# Ingestion
SUBTASK_TO_TASK["Extract VM SKU Metadata"]="Implement Azure Cost Export Ingestion"
SUBTASK_TO_TASK["Clean Malformed Cost Rows"]="Implement Azure Cost Export Ingestion"
SUBTASK_TO_TASK["Implement Currency Normalisation"]="Build Normalisation Pipeline"

# Rightsizing
SUBTASK_TO_TASK["Compute Utilisation Ratio"]="Implement Utilisation Extraction Logic"
SUBTASK_TO_TASK["Map SKU to Recommended Size"]="Build Rightsizing Rule Engine"
SUBTASK_TO_TASK["Generate Rightsizing Recommendation Object"]="Build Rightsizing Rule Engine"

# Idle
SUBTASK_TO_TASK["Identify Zero-Utilisation Signals"]="Identify Idle Resource Signals"
SUBTASK_TO_TASK["Build Idle Resource Flag Logic"]="Build Idle Resource Rule"

# Storage
SUBTASK_TO_TASK["Map Storage Access Patterns"]="Map Storage Tiers"
SUBTASK_TO_TASK["Build Tier Recommendation Logic"]="Build Storage Tiering Rule"

# RI
SUBTASK_TO_TASK["Analyse Consistent Usage Patterns"]="Identify RI Opportunities"
SUBTASK_TO_TASK["Build RI/Savings Plan Mapping"]="Build RI Recommendation Logic"

# Anomaly
SUBTASK_TO_TASK["Prepare Historical Cost Dataset"]="Implement Isolation Forest Model"
SUBTASK_TO_TASK["Tune Isolation Forest Parameters"]="Implement Isolation Forest Model"

# Forecasting
SUBTASK_TO_TASK["Prepare Time-Series Data"]="Build Forecasting Model"
SUBTASK_TO_TASK["Evaluate Forecast Confidence Intervals"]="Evaluate Forecasting Accuracy"

# Reporting
SUBTASK_TO_TASK["Format JSON Output Schema"]="Build JSON Output Generator"
SUBTASK_TO_TASK["Build Markdown Summary Section"]="Build Markdown Report Template"
SUBTASK_TO_TASK["Implement Severity Scoring Logic"]="Add Recommendation Severity Scoring"

# Validation
SUBTASK_TO_TASK["Build Test Dataset Generator"]="Create Test Datasets"
SUBTASK_TO_TASK["Implement Rule Coverage Metrics"]="Add Rule Coverage Metrics"

# UI
SUBTASK_TO_TASK["Build Recommendation Table Component"]="Build Streamlit Dashboard"
SUBTASK_TO_TASK["Add Filter UI Controls"]="Add Filters"
SUBTASK_TO_TASK["Add Cost Trend Charts"]="Add Charts"

for SUB in "${!SUBTASK_TO_TASK[@]}"; do
  PT="${SUBTASK_TO_TASK[$SUB]}"
  TNUM="${TASKS[$PT]}"

  STNUM=$(gh issue create --repo $REPO \
    --title "Sub-task: $SUB" \
    --label subtask \
    --body "Parent Task: #$TNUM" | grep -oP '#\K[0-9]+')

  echo "Sub-task created: #$STNUM ($SUB)"
done

echo "----------------------------------------"
echo " ALL ISSUES CREATED SUCCESSFULLY "
echo "----------------------------------------"
