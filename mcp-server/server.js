import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

// Initialize server
const server = new McpServer({
  name: "space2study-devops-mcp",
  version: "1.0.0",
});

// Tool: Get infrastructure architecture (no input params -> 3 arguments)
server.tool(
  "get_cluster_architecture",
  "Returns architectural details of the Space2Study infrastructure (replicas, ports, networking)",
  async () => ({
    content: [
      {
        type: "text",
        text: JSON.stringify(
          {
            status: "deployed",
            stack: "Space2Study Cloud-Native",
            load_balancer: "Nginx (Port 80)",
            backend_cluster: ["backend1:5000", "backend2:5000"],
            database: "MongoDB 6.0",
            monitoring: ["Prometheus (9090)", "Grafana (3001)", "cAdvisor (8080)"],
          },
          null,
          2
        ),
      },
    ],
  })
);

// Tool: Check system health (no input params -> 3 arguments)
server.tool(
  "check_health",
  "Checks if the Space2Study application and Nginx Load Balancer are responding",
  async () => {
    try {
      const res = await fetch("http://localhost");
      return {
        content: [
          {
            type: "text",
            text: `Space2Study Load Balancer is HEALTHY (HTTP Status: ${res.status})`,
          },
        ],
      };
    } catch (err) {
      return {
        isError: true,
        content: [
          {
            type: "text",
            text: `Health check failed: ${err.message}`,
          },
        ],
      };
    }
  }
);

// Start stdio transport
const transport = new StdioServerTransport();
await server.connect(transport);
console.error("Space2Study MCP Server running on stdio");