# 55-Day DevOps Roadmap (Basic → Medium)

**Ground rule for the whole plan:** every day = ~1.5–2 hrs theory/reading + ~1–2 hrs hands-on. Skipping the hands-on part is the #1 reason these plans fail — DevOps is a "do" skill, not a "read" skill. Keep a single GitHub repo called `devops-journey` and commit something every single day (even a 5-line script). That repo becomes your proof-of-work for interviews.

Since you already know the architecture/basics of several tools, this plan is weighted toward the topics where you need the most net-new depth: **Kubernetes, Terraform, GitHub Actions, Ansible, Networking**.

---

## Week-by-week map

| Days | Topic | Focus |
|---|---|---|
| 1–4 | Shell Scripting (refresh → intermediate) | Automation scripts, not syntax basics |
| 5–7 | Git & GitHub (intermediate) | Branching workflows, rebasing, PR hygiene |
| 8–12 | Docker | Multi-stage builds, networking, volumes, compose |
| 13–17 | Networking | OSI/TCP-IP practical, DNS, load balancing, firewalls |
| 18–22 | GitHub Actions | CI/CD pipelines, matrix builds, secrets, self-hosted runners |
| 23–32 | Kubernetes | Hands-on cluster ops (you already know architecture) |
| 33–40 | Terraform | IaC for real cloud resources, modules, state |
| 41–46 | Ansible | Playbooks, roles, idempotency |
| 47–50 | SQL | Query tuning, joins, indexing, admin basics |
| 51–55 | Capstone project + revision | Tie everything into one pipeline |

---

## Days 1–4: Shell Scripting
Since you know basics, skip "what is a variable" and go straight to:
- Day 1: String/array manipulation, `sed`/`awk`/`grep` in combination, exit codes, `set -euo pipefail`
- Day 2: Functions, argument parsing (`getopts`), reading files line by line, cron
- Day 3: Write a **log-rotation + disk-space alert script** (very relevant to your production support background)
- Day 4: Write a **server health-check script** (CPU/mem/disk/service status, emails/Slack webhook alert on threshold breach)

**Mini-project:** A script that checks 3 servers for disk usage and sends a Slack alert if >80%.

## Days 5–7: Git & GitHub
- Day 5: Branching strategies (Gitflow, trunk-based), rebase vs merge, interactive rebase, cherry-pick
- Day 6: Resolving conflicts, `git bisect`, tags/releases, `.gitignore` patterns, git hooks
- Day 7: GitHub features — branch protection rules, CODEOWNERS, PR templates, issues/projects

**Mini-project:** Set up a repo with branch protection + a pre-commit hook that lints shell scripts.

## Days 8–12: Docker
- Day 8: Multi-stage builds, image layering/caching, `.dockerignore`
- Day 9: Docker networking (bridge, host, overlay), volumes vs bind mounts
- Day 10: Docker Compose — multi-container apps (e.g., app + db + nginx)
- Day 11: Image security basics (distroless, non-root user, scanning with `trivy`)
- Day 12: Registries (Docker Hub, ECR/GHCR), tagging strategy

**Mini-project:** Dockerize a small app (Flask/Node) with a multi-stage build + docker-compose with a DB.

## Days 13–17: Networking
This is the one most people skip and regret — worth doing properly.
- Day 13: OSI/TCP-IP model in practice, subnetting (CIDR), IP routing basics
- Day 14: DNS deep dive (records, resolution flow), `dig`/`nslookup`
- Day 15: Load balancing (L4 vs L7), reverse proxies, nginx config practice
- Day 16: Firewalls, security groups, NAT, VPNs — cloud networking (VPC basics)
- Day 17: TLS/SSL handshake, certificates, HTTPS troubleshooting

**Mini-project:** Set up nginx as a reverse proxy + load balancer in front of 2 Docker containers.

## Days 18–22: GitHub Actions
- Day 18: Workflow syntax, triggers, jobs/steps, runners
- Day 19: Secrets management, environment variables, matrix builds
- Day 20: Build → test → Docker build → push to registry pipeline
- Day 21: Deploy stage (to a VM or cluster), reusable workflows/composite actions
- Day 22: Self-hosted runners, caching dependencies, artifact passing between jobs

**Mini-project:** Full CI/CD pipeline: on push → lint → test → build Docker image → push to GHCR → deploy.

## Days 23–32: Kubernetes (your biggest block — architecture known, now go hands-on)
- Day 23: Local cluster setup (kind/minikube), `kubectl` fluency, Pods/ReplicaSets
- Day 24: Deployments, Services (ClusterIP/NodePort/LoadBalancer), rolling updates/rollbacks
- Day 25: ConfigMaps, Secrets, environment injection
- Day 26: Volumes, PV/PVC, StatefulSets (for stateful apps like DB)
- Day 27: Ingress controllers, Ingress resources, TLS termination
- Day 28: Namespaces, resource requests/limits, HPA (autoscaling)
- Day 29: Liveness/readiness probes, troubleshooting (`describe`, `logs`, `exec`, events)
- Day 30: Helm — charts, templating, installing/upgrading releases
- Day 31: RBAC, ServiceAccounts, basic cluster security
- Day 32: Deploy your Day 20-22 app onto Kubernetes end-to-end

**Mini-project:** Take the app from your Docker/CI-CD work and run it on Kubernetes with Ingress + HPA + a Helm chart.

## Days 33–40: Terraform
- Day 33: HCL syntax, providers, resources, `plan`/`apply`/`destroy`
- Day 34: Variables, outputs, data sources, `terraform.tfvars`
- Day 35: State management — local vs remote (S3+DynamoDB or Terraform Cloud), state locking
- Day 36: Modules — writing and consuming your own module
- Day 37: Provisioning real cloud resources (VPC, EC2/VM, security groups) — use free-tier AWS/Azure/GCP
- Day 38: Workspaces, environments (dev/stage/prod pattern)
- Day 39: `for_each`/`count`, conditionals, dynamic blocks
- Day 40: Provisioning a Kubernetes cluster (EKS/AKS/GKE or a managed node) via Terraform

**Mini-project:** Terraform module that spins up a VPC + a VM + security group, with remote state.

## Days 41–46: Ansible
- Day 41: Inventory, ad-hoc commands, YAML playbook basics
- Day 42: Modules (apt/yum, copy, template, service), variables, facts
- Day 43: Handlers, conditionals, loops, tags
- Day 44: Roles — structure and reuse, `ansible-galaxy`
- Day 45: Vault (secrets), templates with Jinja2
- Day 46: Combine with Terraform — Terraform provisions infra, Ansible configures it

**Mini-project:** Ansible playbook that installs Docker + your app on a VM Terraform just created.

## Days 47–50: SQL
Since you know basics, focus on what production/ops engineers actually get asked:
- Day 47: Joins (all types), subqueries, window functions
- Day 48: Indexing, `EXPLAIN`/query plans, performance tuning
- Day 49: Transactions, locks, isolation levels
- Day 50: Basic DB admin — backups, users/permissions, connection pooling concepts

**Mini-project:** Given a slow query, add the right index and show the before/after `EXPLAIN` plan.

## Days 51–55: Capstone + Revision
- Day 51–52: One end-to-end capstone: Terraform provisions a VM/cluster → Ansible/Docker configures it → GitHub Actions CI/CD builds and deploys the app → app runs on Kubernetes → app talks to a SQL DB. Document it with a README + architecture diagram.
- Day 53: Revise weak spots (whatever felt shakiest in weeks 1–7)
- Day 54: Mock interview prep — write out answers to common questions per topic
- Day 55: Polish your `devops-journey` GitHub repo — README, this capstone pinned at top, resume bullet points drafted from it

---

## Practical notes
- **Cloud account:** Use one provider's free tier (AWS is most commonly asked about) for Terraform/Kubernetes days — don't just simulate everything locally, real cloud quirks (IAM, quotas) are part of the learning.
- **Don't context-switch topics within a day** — the sequencing above is deliberately linear so each topic builds toward the capstone.
- **If a day's topic doesn't stick in one day**, don't panic-extend the whole plan — note it as a gap and hit it again during Days 53–54 revision instead of blowing up the schedule.
- **Given your production-support background**, lean into troubleshooting/observability angles (logs, health checks, alerting) wherever a topic allows — that's a natural differentiator for you in interviews.
