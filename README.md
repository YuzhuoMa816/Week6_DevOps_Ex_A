# Starter App — Exercise A

This is provided as-is. You are not being tested on writing this app —
you're being tested on everything around it: containerizing it, deploying
it, wiring it to a real database, and building the pipeline that ships it.

## What's in here
- `server.js` — the app. Two endpoints:
  - `GET /health` — returns 200, no dependencies.
  - `GET /db-health` — runs a real query against Postgres and returns the result.
    This only works once your RDS instance exists and the app has working
    `DB_HOST` / `DB_PORT` / `DB_NAME` / `DB_USER` / `DB_PASSWORD` env vars.
- `package.json` / `package-lock.json` — dependencies (Express + `pg`).

## What's NOT in here (this is your job)
- `Dockerfile` — write it yourself. Multi-stage, slim/alpine base, non-root user.
- `.dockerignore`
- All Terraform (VPC, RDS, ECS, ALB, IAM, Secrets Manager)
- All CI/CD pipeline YAML (SonarCloud gate, Trivy gate, deploy automation)

Don't modify `server.js`'s logic — if `/db-health` doesn't work, the bug is
almost certainly in your infra/env vars, not in the app code.
