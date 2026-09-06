"""Render a 70-second tour from real emulator screenshots (requires ffmpeg)."""
import argparse
from pathlib import Path
import subprocess
import tempfile

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--ffmpeg', default='ffmpeg')
args = parser.parse_args()
root = Path(__file__).resolve().parents[1]
shots = sorted((root / 'docs/screenshots').glob('*.png'))
if len(shots) != 7:
    raise SystemExit('Expected the seven verified demo screenshots.')
with tempfile.TemporaryDirectory() as directory:
    playlist = Path(directory) / 'frames.txt'
    playlist.write_text(''.join(f"file '{p}'\nduration 10\n" for p in shots) + f"file '{shots[-1]}'\n")
    subprocess.run([
        args.ffmpeg, '-y', '-f', 'concat', '-safe', '0', '-i', str(playlist),
        '-vf', 'scale=480:-2,fps=24', '-t', '70', '-c:v', 'libx264',
        '-pix_fmt', 'yuv420p', '-movflags', '+faststart', '-crf', '23',
        str(root / 'docs/demo-screen-tour.mp4'),
    ], check=True)
