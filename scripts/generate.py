"""Generate and normalize checked-in Dart models identically on local and CI."""
from pathlib import Path
import subprocess

subprocess.run(['dart', 'run', 'build_runner', 'build'], check=True)
subprocess.run(['dart', 'format', 'lib'], check=True)
for path in Path('lib').rglob('*.dart'):
    if path.name.endswith(('.freezed.dart', '.g.dart')):
        path.write_text('\n'.join(line.rstrip() for line in path.read_text().splitlines()) + '\n')
