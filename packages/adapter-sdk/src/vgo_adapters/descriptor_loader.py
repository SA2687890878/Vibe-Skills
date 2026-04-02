import json
from pathlib import Path

from vgo_contracts.adapter_descriptor import AdapterDescriptor


_ALIAS_MAP = {
    'claude': 'claude-code',
}


def _descriptors_root() -> Path:
    return Path(__file__).resolve().parent / 'descriptors'


def _descriptor_file_name(host_id: str) -> str:
    normalized = _ALIAS_MAP.get(host_id.strip().lower(), host_id.strip().lower())
    return normalized.replace('-', '_') + '.json'


def load_descriptor(host_id: str) -> AdapterDescriptor:
    descriptor_path = _descriptors_root() / _descriptor_file_name(host_id)
    if not descriptor_path.exists():
        raise ValueError(f'unsupported adapter id: {host_id}')
    payload = json.loads(descriptor_path.read_text(encoding='utf-8'))
    return AdapterDescriptor(
        id=payload['id'],
        default_target_root=payload['default_target_root']['rel'],
    )
