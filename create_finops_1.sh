#!/bin/bash

REPO="bobgit18/finops-cost-recom-engine"

echo "----------------------------------------"
echo " Creating FULL FinOps Issue Hierarchy"
echo "----------------------------------------"

###############################################################################
# 1. CREATE EPIC
###############################################################################

EPIC_TITLE="Build Cost-Aware FinOps Recommendation Engine"

EPIC_BODY=$(cat << 'EOF'
# Epic: Build Cost-Aware FinOps Recommendation Engine

## 🎯 Goal
Deliver an automated, intelligent FinOps recommendation engine that reduces cloud waste, improves cost visibility, and provides actionable optimisation insights across compute, storage, and platform services.

## 📌 Description
This Epic establishes the foundation for a modular, scalable FinOps engine capable of ingesting cloud cost data, applying rule-based and ML-driven optimisation logic, and producing structured outputs for engineering, finance, and leadership stakeholders.

The scope includes:
- Data ingestion and normalisation
- Rule-based optimisation logic (rightsizing, idle detection, storage tiering, RI/SP opportunities)
- ML-based anomaly detection and forecasting
- Reporting and output generation
- Validation and governance
- UI for consumption

## 🧵 Parent / Portfolio Link (optional)
- Parent Initiative: FinOps Modernisation Programme

## 🧩 Features in this Epic
- [ ] All features listed below will be auto-linked by the creation script.

## 🧪 Acceptance Criteria
- [ ] Clear FinOps value defined
- [ ] Features linked and scoped
- [ ] Cost KPIs identified (e.g., % waste reduction)
- [ ] Stakeholders aligned (FinOps, Cloud Ops, Engineering)

## 📈 Success Metrics
- Reduction in idle resources  
- Rightsizing adoption rate  
- Cost anomaly detection accuracy  
- Cost savings realised  

## 🗂️ Dependencies
- Upstream: Cloud cost export availability  
- Downstream: Reporting, dashboards, governance reviews  

## ✔️ Definition of Done
- All Features completed  
- FinOps KPIs met or validated  
- Documentation updated  
- Stakeholder sign-off completed  
EOF
)

EPIC=$(gh issue create --repo "$REPO" \
  --title "Epic: $EPIC_TITLE" \
  --label epic --label finops \
  --body "$EPIC_BODY" \
  | grep -oP '#\\K[0-9]+')

echo "Epic created: #$EPIC"
echo ""

###############################################################################
# 2. CREATE FEATURES
###############################################################################

declare -A FEATURES
declare -A FEATURE_DESCRIPTIONS

FEATURE_LIST=(
  "Ingest and Normalise Cloud Cost Data"
  "Rule-Based FinOps Recommendations"
  "ML-Based Anomaly Detection"
  "Reporting & Output Layer"
  "Evaluation & Validation Framework"
  "UI Layer (Streamlit Dashboard)"
)

FEATURE_DESCRIPTIONS["Ingest and Normalise Cloud Cost Data"]="Build ingestion pipelines for Azure Cost Exports, normalise cost and usage data, and map metadata to a unified taxonomy."
FEATURE_DESCRIPTIONS["Rule-Based FinOps Recommendations"]="Implement rules for rightsizing, idle resource detection, storage tiering, and RI/SP opportunities."
FEATURE_DESCRIPTIONS["ML-Based Anomaly Detection"]="Develop ML models to detect unusual cost spikes and forecast future spend."
FEATURE_DESCRIPTIONS["Reporting & Output Layer"]="Generate JSON and Markdown outputs for API integration and stakeholder reporting."
FEATURE_DESCRIPTIONS["Evaluation & Validation Framework"]="Create validation harnesses, test datasets, and rule coverage metrics."
FEATURE_DESCRIPTIONS["UI Layer (Streamlit Dashboard)"]="Build a dashboard to visualise recommendations, trends, and anomalies."

for F in "${FEATURE_LIST[@]}"; do

FEATURE_BODY=$(cat << EOF
# Feature: $F

## 🎯 Purpose
${FEATURE_DESCRIPTIONS[$F]}

## 🧵 Parent Epic
- #$EPIC

## 📌 Description
This feature contributes to the FinOps engine by delivering a core capability required for optimisation, visibility, or governance.

## 🧪 Acceptance Criteria
- [ ] Feature delivers measurable value
- [ ] All User Stories linked
- [ ] Edge cases documented
- [ ] Test scenarios identified

## 🧱 User Stories
- [ ] Stories will be auto-linked by the script.

## 🗂️ Dependencies
- Upstream: Cloud cost data availability  
- Downstream: Reporting, dashboards  

## ✔️ Definition of Done
- All User Stories completed  
- Tests passed  
- Documentation updated  
- Demo completed  
EOF
)

  FNUM=$(gh issue create --repo "$REPO" \
    --title "Feature: $F" \
    --label feature --label finops \
    --body "$FEATURE_BODY" \
    | grep -oP '#\\K[0-9]+')

  FEATURES["$F"]=$FNUM
  echo "Feature created: #$FNUM ($F)"
done

echo ""

###############################################################################
# 3. CREATE STORIES
###############################################################################

declare -A STORIES
declare -A STORY_TO_FEATURE
declare -A STORY_CONTENT

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

# STORY CONTENT (highly detailed)
STORY_CONTENT["Ingest Azure Cost Export Data"]="As a FinOps practitioner, I want to ingest Azure Cost Export data so that I can analyse spend at resource, tag, and service granularity."
STORY_CONTENT["Normalise Cost & Usage Data"]="As a FinOps practitioner, I want cost and usage data normalised so that recommendations are accurate and comparable across services."
STORY_CONTENT["Rightsizing Recommendations"]="As an engineer, I want rightsizing recommendations so that I can reduce over-provisioned compute resources."
STORY_CONTENT["Idle Resource Detection"]="As a FinOps analyst, I want to detect idle resources so that I can eliminate waste."
STORY_CONTENT["Storage Tiering Recommendations"]="As a storage owner, I want tiering recommendations so that I can reduce storage costs."
STORY_CONTENT["Reserved Instance Opportunities"]="As a finance stakeholder, I want RI/SP opportunities so that I can reduce long-term compute costs."
STORY_CONTENT["Cost Anomaly Detection"]="As a FinOps team, I want anomaly detection so that I can identify unexpected cost spikes."
STORY_CONTENT["Cost Forecasting"]="As a finance team, I want cost forecasting so that I can plan budgets accurately."
STORY_CONTENT["JSON Output for API Integration"]="As a platform team, I want JSON outputs so that I can integrate recommendations into automation pipelines."
STORY_CONTENT["Markdown Report for Stakeholders"]="As a stakeholder, I want Markdown reports so that I can review optimisation insights easily."
STORY_CONTENT["Validate Recommendations Against FinOps Best Practices"]="As a FinOps lead, I want validation so that recommendations align with industry standards."
STORY_CONTENT["UI to View Recommendations"]="As an engineer, I want a dashboard so that I can explore recommendations visually."

for STORY in "${!STORY_TO_FEATURE[@]}"; do
  PF="${STORY_TO_FEATURE[$STORY]}"
  FNUM="${FEATURES[$PF]}"

STORY_BODY=$(cat << EOF
# User Story: $STORY

## 👤 As a…
${STORY_CONTENT[$STORY]}

## 🎯 I want to…
Deliver this capability as part of the FinOps optimisation workflow.

## 💡 So that…
Stakeholders can take action on cost insights and reduce cloud waste.

---

## 🧪 Acceptance Criteria (Gherkin Format)
- **Given** valid cost data  
- **When** the system processes the dataset  
- **Then** it produces accurate and actionable outputs  

---

## 🧱 Tasks
- [ ] Tasks will be auto-linked by the script.

## 🗂️ Dependencies
- Upstream: Feature implementation  
- Downstream: Reporting, dashboards  

## ✔️ Definition of Done
- Acceptance criteria met  
- Tests written and passed  
- Story demoed to stakeholders  
- Documentation updated  
EOF
)

  SNUM=$(gh issue create --repo "$REPO" \
    --title "Story: $STORY" \
    --label story --label finops \
    --body "$STORY_BODY" \
    | grep -oP '#\\K[0-9]+')

  STORIES["$STORY"]=$SNUM
  echo "Story created: #$SNUM ($STORY)"
done

echo ""

###############################################################################
# 4. CREATE TASKS
###############################################################################

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

TASK_BODY=$(cat << EOF
# Task: $TASK

## 🧵 Parent Story
- #$SNUM

## 📌 Description
This task implements a core part of the FinOps capability for the associated story.  
It includes detailed technical work such as data processing, rule logic, ML model development, or UI implementation.

## 🧱 Sub‑tasks
- [ ] Sub‑tasks will be auto-linked by the script.

## 🧪 Acceptance Criteria
- [ ] Task delivers required functionality  
- [ ] No breaking changes introduced  
- [ ] Tests written and passing  

## ✔️ Definition of Done
- Code implemented  
- Tests written  
- PR raised and reviewed  
- Merged into main branch  
EOF
)

  TNUM=$(gh issue create --repo "$REPO" \
    --title "Task: $TASK" \
    --label task --label finops \
    --body "$TASK_BODY" \
    | grep -oP '#\\K[0-9]+')

  TASKS["$TASK"]=$TNUM
  echo "Task created: #$TNUM ($TASK)"
done

echo ""

###############################################################################
# 5. CREATE SUB-TASKS
###############################################################################

declare -A SUBTASK_TO_TASK

SUBTASK_TO_TASK["Extract VM SKU Metadata"]="Implement Azure Cost Export Ingestion"
SUBTASK_TO_TASK["Clean Malformed Cost Rows"]="Implement Azure Cost Export Ingestion"
SUBTASK_TO_TASK["Implement Currency Normalisation"]="Build Normalisation Pipeline"

SUBTASK_TO_TASK["Compute Utilisation Ratio"]="Implement Utilisation Extraction Logic"

SUBTASK_TO_TASK["Compute Utilisation Ratio"]="Implement Utilisation Extraction Logic"
SUBTASK_TO_TASK["Generate Rightsizing Evidence"]="Build Rightsizing Rule Engine"

SUBTASK_TO_TASK["Identify Idle Metrics"]="Identify Idle Resource Signals"
SUBTASK_TO_TASK["Implement Idle Rule Logic"]="Build Idle Resource Rule"

SUBTASK_TO_TASK["Analyse Storage Access Patterns"]="Map Storage Tiers"
SUBTASK_TO_TASK["Implement Tiering Logic"]="Build Storage Tiering Rule"

SUBTASK_TO_TASK["Collect RI Usage Data"]="Identify RI Opportunities"
SUBTASK_TO_TASK["Calculate RI Savings"]="Build RI Recommendation Logic"

SUBTASK_TO_TASK["Train Isolation Forest"]="Implement Isolation Forest Model"
SUBTASK_TO_TASK["Tune Anomaly Thresholds"]="Implement Isolation Forest Model"

SUBTASK_TO_TASK["Prepare Training Data"]="Build Forecasting Model"
SUBTASK_TO_TASK["Evaluate Forecast Accuracy"]="Evaluate Forecasting Accuracy"

SUBTASK_TO_TASK["Generate JSON Schema"]="Build JSON Output Generator"

SUBTASK_TO_TASK["Write Markdown Sections"]="Build Markdown Report Template"
SUBTASK_TO_TASK["Implement Severity Scoring"]="Add Recommendation Severity Scoring"

SUBTASK_TO_TASK["Build Validation Scripts"]="Build Validation Harness"
SUBTASK_TO_TASK["Create Synthetic Test Data"]="Create Test Datasets"
SUBTASK_TO_TASK["Compute Rule Coverage"]="Add Rule Coverage Metrics"

SUBTASK_TO_TASK["Implement Dashboard Layout"]="Build Streamlit Dashboard"
SUBTASK_TO_TASK["Add Filter Widgets"]="Add Filters"
SUBTASK_TO_TASK["Add Cost Charts"]="Add Charts"

echo "Creating Sub‑tasks..."
echo ""

for SUBTASK in "${!SUBTASK_TO_TASK[@]}"; do
  PT="${SUBTASK_TO_TASK[$SUBTASK]}"
  TNUM="${TASKS[$PT]}"

SUBTASK_BODY=$(cat << EOF
# Sub-task: $SUBTASK

## 🧵 Parent Task
- #$TNUM

## 📌 Description
This sub-task delivers a specific, granular piece of work required to complete the parent task.  
It focuses on a single unit of technical implementation, validation, or data processing.

## 🧪 Acceptance Criteria
- [ ] Work completed as described  
- [ ] No regressions introduced  
- [ ] Verified by parent Task owner  

## ✔️ Definition of Done
- Work completed  
- Reviewed and validated  
- Linked Task updated  
EOF
)

  STNUM=$(gh issue create --repo "$REPO" \
    --title "Sub-task: $SUBTASK" \
    --label subtask --label finops \
    --body "$SUBTASK_BODY" \
    | grep -oP '#\\K[0-9]+')

  echo "Sub-task created: #$STNUM ($SUBTASK)"
done

echo ""
echo "----------------------------------------"
echo " FINOPS HIERARCHY CREATION COMPLETE"
echo "----------------------------------------"
echo "Epic: #$EPIC"
echo "Features: ${FEATURES[@]}"
echo "Stories: ${STORIES[@]}"
echo "Tasks: ${TASKS[@]}"
echo "Sub-tasks created successfully."
