# Security

Do not commit signing keys, credentials or local define files. Report reproducible security issues privately to the repository owner; do not post tokens or personal data in issues.

Release builds require an explicit HTTPS backend unless local-demo mode is enabled. The local demo is not intended for public network exposure. Password and token payloads must not be logged.

Dependencies are pinned by pubspec.lock and reviewed through CI/Dependabot. The backend owns authorization, session rotation and input validation. Public user payloads deliberately exclude email.
