"""Query OSV for hosted Pub packages in the committed lockfile (stdlib only)."""
import json
import re
import urllib.request
from pathlib import Path

lock = Path('pubspec.lock').read_text()
packages = []
for match in re.finditer(r'^  ([\w_]+):\n(.*?)(?=^  [\w_]+:|^sdks:|\Z)', lock, re.M | re.S):
    name, block = match.groups()
    version = re.search(r'^    version: [\"\']?([^\"\'\n]+)', block, re.M)
    if version and 'source: hosted' in block:
        packages.append((name, version.group(1)))
request = urllib.request.Request('https://api.osv.dev/v1/querybatch',
    data=json.dumps({'queries': [{'package': {'name': n, 'ecosystem': 'Pub'}, 'version': v} for n, v in packages]}).encode(),
    headers={'Content-Type': 'application/json'})
with urllib.request.urlopen(request, timeout=60) as response:
    results = json.load(response)['results']
findings = [(name, version, [v['id'] for v in result.get('vulns', [])])
            for (name, version), result in zip(packages, results) if result.get('vulns')]
for finding in findings:
    print(*finding)
print(f'Queried {len(packages)} hosted packages; {len(findings)} packages with advisories.')
raise SystemExit(1 if findings else 0)
