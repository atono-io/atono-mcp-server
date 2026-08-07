# Atono MCP Server

**Give your AI coding tools your team's product context.**

Your AI tools are fast, confident, and guessing at how your product actually
works. They can only act on the context they can reach — so they produce work 
that looks right, passes review, ships, and fails weeks later.

The Atono MCP server connects Claude Code, Claude Desktop, Cursor, VS Code, 
Copilot, Windsurf, and Codex directly to an [Atono](https://atono.io) workspace. 
**41 tools** for reading and writing stories, bugs, epics, subtasks, acceptance 
criteria, and timeboxes — plus the two things that actually change output quality: 
your workspace **glossary of product concepts**, and per-item **AI context** 
(design decisions, investigations, summaries).

Agents stop relearning your domain on every session.

## Quick start
**Prerequisites**

1. [Docker Desktop](https://www.docker.com/products/docker-desktop/) v27.0 or later, running in the background
2. An Atono API key — workspace settings → Manage API keys
3. An MCP-enabled tool

### Claude Code
```shell
claude mcp add --transport stdio atono \
  --env X_API_KEY=YOUR_ATONO_API_KEY \
  -- docker run --pull=always -i --rm -e X_API_KEY atonoai/atono-mcp-server:latest
```

Run `/mcp` to confirm Atono appears.

### Claude Desktop
`claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "atono": {
      "command": "docker",
      "args": [
        "run", "--pull=always", "-i", "--rm",
        "-e", "X_API_KEY=YOUR_ATONO_API_KEY",
        "atonoai/atono-mcp-server:latest"
      ]
    }
  }
}
```

### Cursor
One-step install via the [Cursor MCP directory](https://cursor.directory/plugins/mcp-atono), 
or add to `mcp.json`:

```json
{
  "mcpServers": {
    "atono-mcp-server": {
      "command": "docker",
      "args": [
        "run", "--pull=always", "-i", "--rm",
        "-e", "X_API_KEY=YOUR_ATONO_API_KEY",
        "atonoai/atono-mcp-server:latest"
      ]
    }
  }
}
```

### VS Code (GitHub Copilot)
Copilot Chat → Configure Tools → Add MCP Server → Docker Image → `atonoai/atono-mcp-server:latest`, 
then use the same JSON in `.vscode/mcp.json` and restart the server.

### Windsurf
Same JSON as Cursor, in `mcp_config.json`. Restart Windsurf.

### OpenAI Codex
`~/.codex/config.toml`:

```toml
[mcp_servers.atono]
command = "docker"
args = ["run", "--pull=always", "-i", "--rm", "-e", "X_API_KEY", "atonoai/atono-mcp-server:latest"]

[mcp_servers.atono.env]
X_API_KEY = "YOUR_ATONO_API_KEY"
```

**Verify:** ask your assistant *"What Atono MCP tools are available?"*

**Updates:** none required. `--pull=always` fetches the latest image on restart.

## The 41 tools
**Setup & context (5)** `atono_configuration · atono_list_users · atono_list_teams · atono_get_team_workflow · atono_get_glossary`

**Stories (10)** `atono_get_story · atono_list_story_personas · atono_create_story · atono_update_story_title · atono_update_story_content · atono_update_story_ac · atono_update_story_additional_content · atono_update_story_team · atono_update_story_step · atono_update_story_assignee`

**Bugs (7)** `atono_list_environments · atono_get_bug · atono_create_bug · atono_update_bug · atono_update_bug_step · atono_update_bug_assignee · atono_document_bug_fix`

**Epics (7)** `atono_create_epic · atono_get_epic · atono_update_epic_title · atono_update_epic_description · atono_update_epic_user_stories · atono_add_story_to_epic · atono_remove_story_from_epic`

**Subtasks (4)** `atono_get_subtasks · atono_create_subtask · atono_update_subtask · atono_delete_subtask`

**Attachments (3)** `atono_upload_file_url · atono_create_attachment · atono_get_attachment`

**Timeboxes (2)** `atono_list_timeboxes · atono_list_timebox_items`

**Linked items (1)** `atono_link_bugs_or_stories`

**AI context (2)** `atono_get_ai_context · atono_update_ai_context`

Full reference: [docs.atono.io/docs/atono-mcp-tools](https://docs.atono.io/docs/atono-mcp-tools)

## Agent cautions
- **Always call** `atono_get_ai_context` before `atono_update_ai_context`.
- **Some writes replace rather than append.** `atono_update_story_ac` and 
  `atono_update_epic_user_stories` replace *all* criteria/statements. Same for 
  `atono_update_epic_description` and `atono_update_story_additional_content`.
  Read first.
- The server reaches only the workspace the API key authenticates to. It 
  exposes defined Atono actions and nothing else.
- Treat API keys as passwords. Never commit them.
- Agent actions are attributed and auditable — MCP-performed changes show 
  "Performed by MCP server" in Activities, and the human driver stays the attributed author.

## Plans
The MCP server works on **every** Atono plan, including Free (up to 25 users).

One thing worth knowing up front: **Glossary and AI Context are a 30-day trial on 
the Free plan**. Connect an agent to a Free workspace past its trial and you'll 
find the tools present but the context they fetch empty. That's a licensing 
state, not a bug — it's the most common surprise, so we'd rather say it here.

| | Free | Starter | Growth |
|-|------|---------|--------|
| MCP server & all 41 tools | ✓ | ✓ | ✓ |
| Product Knowledge (Glossary + AI Context) | 30-day trial | ✓ | ✓ |
| Price | $0, up to 25 users | $19/user/mo | $39/user/mo |

[atono.io/pricing](https://atono.io/pricing)

## About Atono
Atono is the product engineering platform that keeps product context connected 
to the work, so your team and its AI agents build what you actually intend — not 
just what looks right.

A story in Atono carries its acceptance criteria, the feature flag controlling 
its rollout, the usage data proving whether it worked, and the AI context agents 
read — in one object. In a conventional stack those four live in four products, 
and the context is destroyed at every seam.

[atono.io](https://atono.io) · [docs](https://docs.atono.io) · [MCP server docs](https://docs.atono.io/docs/mcp-server-for-atono)

