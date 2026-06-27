# 🏗️ platform-infra

A production-grade **Platform Infrastructure** monorepo for managing cloud infrastructure, Kubernetes clusters, CI/CD pipelines, and GitOps workflows using **Terraform**, **ArgoCD**, and **Docker**.

---

## 📁 Repository Structure

```
platform-infra/
├── app/                        # Application manifests and configurations
├── ci/                         # CI/CD pipeline definitions
├── gitops/                     # ArgoCD GitOps configurations and app definitions
├── infra/
│   └── accounts/
│       └── dev-account/
│           └── regions/
│               └── us-east-1/
│                   └── dev/
│                       └── cluster-1/   # EKS cluster Terraform config (dev)
├── modules/                    # Reusable Terraform modules
└── .gitignore
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Infrastructure as Code | Terraform (HCL) |
| GitOps / CD | ArgoCD |
| Container Runtime | Docker |
| Templating | Go Templates (Helm) |
| Automation / Scripts | Python |
| Cloud Provider | AWS (us-east-1) |

---

## 🚀 Key Components

### `infra/`
Terraform configurations organized by **account → region → environment → cluster**. Currently manages a dev EKS cluster in AWS `us-east-1`.

### `modules/`
Reusable, composable Terraform modules to provision and manage cloud resources consistently across environments.

### `gitops/`
ArgoCD application definitions and sync configurations. Enables declarative, Git-driven continuous delivery to Kubernetes.

### `ci/`
CI pipeline definitions for building, testing, and packaging application artifacts before delivery.

### `app/`
Application-level Kubernetes manifests or Helm chart values deployed via the GitOps workflow.

---

## ⚡ Getting Started

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.x
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [ArgoCD CLI](https://argo-cd.readthedocs.io/en/stable/cli_installation/)
- AWS CLI configured with appropriate credentials
- Python 3.x (for helper scripts)

### Provision Infrastructure

```bash
cd infra/accounts/dev-account/regions/us-east-1/dev/cluster-1

terraform init
terraform plan
terraform apply
```

### Bootstrap GitOps

```bash
# Install ArgoCD on the cluster
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Apply GitOps app definitions
kubectl apply -f gitops/
```

---

## 🔐 Security Notes

- Terraform state files (`*.tfstate`) are excluded from version control.
- ArgoCD SSH keys (`argocd-github`, `argocd-github.pub`) and repo secrets (`repo-secret.yaml`) are gitignored — never commit secrets.
- Use a remote backend (e.g., S3 + DynamoDB) for shared Terraform state.

---

## 🗺️ Infrastructure Layout

```
AWS Account: dev-account
└── Region: us-east-1
    └── Environment: dev
        └── Cluster: cluster-1 (EKS)
```

---

## 📦 Language Breakdown

- **HCL** — 93.9% (Terraform infrastructure definitions)
- **Go Template** — 2.8% (Helm chart templating)
- **Python** — 2.0% (automation and helper scripts)
- **Dockerfile** — 1.3% (container image definitions)

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push and open a Pull Request

---

## 📄 License

This project is private. All rights reserved.
