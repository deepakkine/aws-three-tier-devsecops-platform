# Contributing

Thank you for your interest in contributing to this project.

## Prerequisites

Before contributing, ensure you have the following installed:

- Git
- Docker
- Terraform
- kubectl
- Helm
- AWS CLI

## Getting Started

1. Fork the repository.
2. Clone your fork.

```bash
git clone https://github.com/<your-username>/aws-three-tier-devsecops-platform.git
```

3. Create a new feature branch.

```bash
git checkout -b feature/my-feature
```

4. Make your changes.

5. Test your changes.

6. Commit using meaningful commit messages.

Example:

```text
feat(terraform): add GitHub OIDC module

fix(helm): update ingress annotations

docs: improve deployment guide
```

7. Push your branch.

```bash
git push origin feature/my-feature
```

8. Open a Pull Request.

## Coding Guidelines

- Follow Terraform best practices.
- Use reusable Terraform modules.
- Keep Helm charts organized.
- Keep GitHub Actions workflows readable.
- Update documentation whenever infrastructure changes.

## Reporting Issues

If you discover a bug, please open an Issue describing:

- Expected behavior
- Actual behavior
- Steps to reproduce
- Relevant logs or screenshots

Thank you for contributing!