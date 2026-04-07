from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[2]


def test_install_prompts_define_native_mcp_first_as_completion_target() -> None:
    zh_prompt = (REPO_ROOT / "docs/install/prompts/full-version-install.md").read_text(encoding="utf-8")
    en_prompt = (REPO_ROOT / "docs/install/prompts/full-version-install.en.md").read_text(encoding="utf-8")

    assert "宿主原生 MCP" in zh_prompt
    assert "native MCP surface" in en_prompt
    assert "$vibe" in zh_prompt and "不等于 MCP" in zh_prompt
    assert "$vibe" in en_prompt and "not MCP completion" in en_prompt


def test_supporting_install_docs_reject_template_and_sidecar_as_mcp_completion() -> None:
    zh_recommended = (REPO_ROOT / "docs/install/recommended-full-path.md").read_text(encoding="utf-8")
    en_recommended = (REPO_ROOT / "docs/install/recommended-full-path.en.md").read_text(encoding="utf-8")
    zh_rules = (REPO_ROOT / "docs/install/installation-rules.md").read_text(encoding="utf-8")
    en_rules = (REPO_ROOT / "docs/install/installation-rules.en.md").read_text(encoding="utf-8")

    assert "template" in en_recommended.lower() or "manifest" in en_recommended.lower() or "sidecar" in en_recommended.lower()
    assert "宿主原生 MCP" in zh_recommended
    assert "native MCP surface" in en_recommended
    assert "sidecar" in zh_rules or "manifest" in zh_rules
    assert "sidecar" in en_rules or "manifest" in en_rules


def test_readme_keeps_vibe_as_runtime_entry_but_not_mcp_proof() -> None:
    readme_en = (REPO_ROOT / "README.md").read_text(encoding="utf-8")
    readme_zh = (REPO_ROOT / "README.zh.md").read_text(encoding="utf-8")

    assert "$vibe" in readme_en
    assert "$vibe" in readme_zh
    assert "not MCP completion" in readme_en
    assert "不等于 MCP" in readme_zh
