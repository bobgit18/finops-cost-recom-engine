

gh issue create --repo $REPO --title "Task: Implement Azure Cost Export Ingestion" --body "Parent Story: #S1" --label task
gh issue create --repo $REPO --title "Task: Parse Resource Metadata" --body "Parent Story: #S1" --label task
gh issue create --repo $REPO --title "Task: Validate Ingestion with Sample Dataset" --body "Parent Story: #S1" --label task

gh issue create --repo $REPO --title "Task: Build Normalisation Pipeline" --body "Parent Story: #S2" --label task
gh issue create --repo $REPO --title "Task: Map Services to Standard Taxonomy" --body "Parent Story: #S2" --label task

gh issue create --repo $REPO --title "Task: Implement Utilisation Extraction Logic" --body "Parent Story: #S3" --label task
gh issue create --repo $REPO --title "Task: Build Rightsizing Rule Engine" --body "Parent Story: #S3" --label task
gh issue create --repo $REPO --title "Task: Write Unit Tests for Rightsizing" --body "Parent Story: #S3" --label task

gh issue create --repo $REPO --title "Task: Identify Idle Resource Signals" --body "Parent Story: #S4" --label task
gh issue create --repo $REPO --title "Task: Build Idle Resource Rule" --body "Parent Story: #S4" --label task

gh issue create --repo $REPO --title "Task: Map Storage Tiers" --body "Parent Story: #S5" --label task
gh issue create --repo $REPO --title "Task: Build Storage Tiering Rule" --body "Parent Story: #S5" --label task

gh issue create --repo $REPO --title "Task: Identify RI Opportunities" --body "Parent Story: #S6" --label task
gh issue create --repo $REPO --title "Task: Build RI Recommendation Logic" --body "Parent Story: #S6" --label task

gh issue create --repo $REPO --title "Task: Implement Isolation Forest Model" --body "Parent Story: #S7" --label task

gh issue create --repo $REPO --title "Task: Build Forecasting Model" --body "Parent Story: #S8" --label task
gh issue create --repo $REPO --title "Task: Evaluate Forecasting Accuracy" --body "Parent Story: #S8" --label task

gh issue create --repo $REPO --title "Task: Build JSON Output Generator" --body "Parent Story: #S9" --label task

gh issue create --repo $REPO --title "Task: Build Markdown Report Template" --body "Parent Story: #S10" --label task
gh issue create --repo $REPO --title "Task: Add Recommendation Severity Scoring" --body "Parent Story: #S10" --label task

gh issue create --repo $REPO --title "Task: Build Validation Harness" --body "Parent Story: #S11" --label task
gh issue create --repo $REPO --title "Task: Create Test Datasets" --body "Parent Story: #S11" --label task
gh issue create --repo $REPO --title "Task: Add Rule Coverage Metrics" --body "Parent Story: #S11" --label task

gh issue create --repo $REPO --title "Task: Build Streamlit Dashboard" --body "Parent Story: #S12" --label task
gh issue create --repo $REPO --title "Task: Add Filters (Service, Severity, Cost Impact)" --body "Parent Story: #S12" --label task
gh issue create --repo $REPO --title "Task: Add Charts (Cost Trends, Anomalies)" --body "Parent Story: #S12" --label task

