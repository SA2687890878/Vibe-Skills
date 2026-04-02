from pathlib import Path
import json


def _load_payload(adapter_id: str):
    descriptor_name = adapter_id.replace('-', '_') + '.json'
    path = Path(__file__).resolve().parent / 'descriptors' / descriptor_name
    return json.loads(path.read_text(encoding='utf-8'))


def resolve_default_target_root(descriptor, *, env: dict[str, str] | None = None, home: str | None = None) -> str:
    env = env or {}
    home = home or str(Path.home())
    payload = _load_payload(descriptor.id)
    target = payload['default_target_root']
    env_name = target.get('env')
    if env_name and env.get(env_name):
        return env[env_name]
    rel = str(target.get('rel') or '').strip()
    if not rel:
        raise ValueError(f'missing default target root for {descriptor.id}')
    if rel.startswith('/'):
        return rel
    return str(Path(home) / rel)
