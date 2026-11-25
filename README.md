# Atono MCP Server

**Give your AI coding tools your team's product context.**

Your AI tools are fast, confident, and guessing at how your product actually
works. They can only act on the context they can reach — so they produce work
that looks right, passes review, ships, and fails weeks later.

The Atono MCP server connects Claude Code, Claude Desktop, Cursor, VS Code, Copilot,
Windsurf, and Codex directly to an [Atono](https://atono.io) workspace.
**42 tools** for reading and writing stories, bugs, epics, subtasks, acceptance
criteria, and timeboxes — plus the two things that actually change output quality:
your workspace **glossary of product concepts**, and per-item **AI context**
(design decisions, investigations, summaries).

Agents stop relearning your domain on every session.

## Connect

`https://mcp.atono.io/mcp` — sign in with OAuth when prompted.

### Claude Code

```shell
claude mcp add --transport http atono https://mcp.atono.io/mcp
```

### Claude Desktop

Settings → Connectors → Add custom connector → `https://mcp.atono.io/mcp`

### Cursor

`mcp.json`:

```json
{
  "mcpServers": {
    "atono": {
      "type": "http",
      "url": "https://mcp.atono.io/mcp"
    }
  }
}
```

### VS Code

`.vscode/mcp.json`:

```json
{
  "servers": {
    "atono": {
      "type": "http",
      "url": "https://mcp.atono.io/mcp"
    }
  }
}
```

### Windsurf

`mcp_config.json`:

```json
{
  "mcpServers": {
    "atono": {
      "serverUrl": "https://mcp.atono.io/mcp"
    }
  }
}
```

### OpenAI Codex

```shell
codex mcp add atono --url https://mcp.atono.io/mcp
```

## Run locally (optional, Docker)

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
        "run",
        "--pull=always",
        "-i",
        "--rm",
        "-e",
        "X_API_KEY=YOUR_ATONO_API_KEY",
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
        "run",
        "--pull=always",
        "-i",
        "--rm",
        "-e",
        "X_API_KEY=YOUR_ATONO_API_KEY",
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

**Verify:** ask your assistant _"What Atono MCP tools are available?"_

**Updates:** none required. `--pull=always` fetches the latest image on restart.

## Tools

42 tools. Full reference: [docs.atono.io/docs/atono-mcp-tools](https://docs.atono.io/docs/atono-mcp-tools)

### Setup & context

| Tool                      | Description                                                        |
| ------------------------- | ------------------------------------------------------------------ |
| `atono_configuration`     | Verify the connection and return the workspace name and user count |
| `atono_list_users`        | List workspace users, or the members of one team                   |
| `atono_list_teams`        | List the teams in the workspace                                    |
| `atono_get_team_workflow` | Get the workflow steps defined for a team                          |
| `atono_get_glossary`      | Get the full product glossary (TSV)                                |

### Stories

| Tool                                    | Description                                                                 |
| --------------------------------------- | --------------------------------------------------------------------------- |
| `atono_get_story`                       | Get a story with its acceptance criteria, subtask summary, and feature flag |
| `atono_list_story_personas`             | List the story personas defined in the workspace                            |
| `atono_create_story`                    | Create a story with user stories, acceptance criteria, and optional team    |
| `atono_update_story_title`              | Update a story's title                                                      |
| `atono_update_story_content`            | Update a story's user story statements                                      |
| `atono_update_story_ac`                 | Replace all acceptance criteria on a story                                  |
| `atono_update_story_additional_content` | Replace a story's additional content                                        |
| `atono_update_story_team`               | Assign a story to a team, or unassign it                                    |
| `atono_update_story_step`               | Move a story to another workflow step within its team                       |
| `atono_update_story_assignee`           | Assign a story to a user, or unassign it                                    |

### Bugs

| Tool                        | Description                                                                  |
| --------------------------- | ---------------------------------------------------------------------------- |
| `atono_list_environments`   | List the environments in the workspace                                       |
| `atono_get_bug`             | Get a bug with its reproduction steps, behavior, and subtask summary         |
| `atono_create_bug`          | Create a bug with summary, reproduction steps, and expected/actual behavior  |
| `atono_update_bug`          | Update a bug's fields; list fields such as environments are replaced in full |
| `atono_update_bug_step`     | Move a bug to another workflow step within its team                          |
| `atono_update_bug_assignee` | Assign a bug to a user, or unassign it                                       |
| `atono_document_bug_fix`    | Add a plain-English summary of a fix to the bottom of a bug's description    |

### Linked items

| Tool                         | Description              |
| ---------------------------- | ------------------------ |
| `atono_link_bugs_or_stories` | Link two stories or bugs |

### Subtasks

| Tool                   | Description                                              |
| ---------------------- | -------------------------------------------------------- |
| `atono_get_subtasks`   | List the subtasks on a story or bug                      |
| `atono_create_subtask` | Add a subtask to a story or bug                          |
| `atono_update_subtask` | Update a subtask's title, description, assignee, or step |
| `atono_delete_subtask` | Permanently delete a subtask from a story or bug         |

### Epics

| Tool                             | Description                                                 |
| -------------------------------- | ----------------------------------------------------------- |
| `atono_list_epics`               | List epics, optionally filtered by title keyword            |
| `atono_create_epic`              | Create an epic with user story statements and a description |
| `atono_get_epic`                 | Get an epic with its user stories and ordered child stories |
| `atono_update_epic_title`        | Rename an epic (titles must be unique)                      |
| `atono_update_epic_description`  | Replace an epic's description in full                       |
| `atono_update_epic_user_stories` | Replace all user story statements on an epic                |
| `atono_add_story_to_epic`        | Add a story to an epic, or move it from another epic        |
| `atono_remove_story_from_epic`   | Remove a story from an epic                                 |

### Attachments

| Tool                      | Description                                        |
| ------------------------- | -------------------------------------------------- |
| `atono_upload_file_url`   | Get a URL for uploading a file to the staging area |
| `atono_create_attachment` | Attach a staged file to a story or bug             |
| `atono_get_attachment`    | Get an attachment's details and download URL       |

### Timeboxes

| Tool                       | Description                                 |
| -------------------------- | ------------------------------------------- |
| `atono_list_timeboxes`     | List timeboxes, optionally only active ones |
| `atono_list_timebox_items` | List the stories and bugs in a timebox      |

### AI context

| Tool                      | Description                                                               |
| ------------------------- | ------------------------------------------------------------------------- |
| `atono_get_ai_context`    | Get an item's AI context (design, investigation, summary, or QA analysis) |
| `atono_update_ai_context` | Create or replace an item's AI context resource                           |

## Agent cautions

- **Always call** `atono_get_ai_context` before `atono_update_ai_context`.
- **Some writes replace rather than append.** `atono_update_story_ac` and
  `atono_update_epic_user_stories` replace _all_ criteria/statements. Same for
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

|                                           | Free               | Starter     | Growth      |
| ----------------------------------------- | ------------------ | ----------- | ----------- |
| MCP server & all 42 tools                 | ✓                  | ✓           | ✓           |
| Product Knowledge (Glossary + AI Context) | 30-day trial       | ✓           | ✓           |
| Price                                     | $0, up to 25 users | $19/user/mo | $39/user/mo |

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
