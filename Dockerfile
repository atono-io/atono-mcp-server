FROM python:3.14-slim

# Set working directory
WORKDIR /app

# Copy the project files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -e .

# Expose the port used by the MCP server in SSE mode
EXPOSE 8000

# Command to run the MCP server in SSE mode
# CMD ["python", "-m", "atono_mcp_server", "--sse", "--host", "0.0.0.0", "--port", "8000"]

# Accept version as build argument (passed from GitHub Actions)
ARG VERSION=0.1.0

# Add metadata labels
LABEL io.modelcontextprotocol.server.name="io.atono/atono-mcp-server"
LABEL version=$VERSION \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.title="Atono MCP Server" \
    org.opencontainers.image.description="MCP Server for Atono — connect AI systems to your team’s workflow intelligence platform."

# Command to run in stdio mode
CMD ["python", "-m", "atono_mcp_server"]
