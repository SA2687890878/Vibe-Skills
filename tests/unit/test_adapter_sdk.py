from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
SRC = ROOT / 'packages' / 'adapter-sdk' / 'src'
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))

from vgo_adapters.descriptor_loader import load_descriptor
from vgo_adapters.target_root_resolver import resolve_default_target_root


def test_codex_descriptor_has_default_target_rule() -> None:
    descriptor = load_descriptor('codex')
    assert descriptor.id == 'codex'
    assert descriptor.default_target_root is not None


def test_target_root_resolver_uses_env_when_available() -> None:
    descriptor = load_descriptor('codex')
    resolved = resolve_default_target_root(descriptor, env={'CODEX_HOME': '/tmp/codex-home'}, home='/home/tester')
    assert resolved == '/tmp/codex-home'


def test_target_root_resolver_falls_back_to_home_relative_path() -> None:
    descriptor = load_descriptor('opencode')
    resolved = resolve_default_target_root(descriptor, env={}, home='/home/tester')
    assert resolved == '/home/tester/.config/opencode'
