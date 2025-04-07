import mcp.server;
import mcp.schema;

import std.stdio;
import std.json;
import std.uuid;

void main()
{
    auto server = new MCPServer("Generate UUID Server", "1.0.0");

    server.addTool(
        "generate_uuid",
        "Generate UUIDs",
        SchemaBuilder.object()
            .addProperty("size", 
                SchemaBuilder.number()
                    .setDescription("Number of UUIDs to generate. default: 1")
                    .optional()
                    .range(1, 100)),
        (JSONValue args) {
            auto size = args["size"].get!long();
            auto uuids = new string[size];
            foreach (i; 0 .. size) {
                uuids[i] = randomUUID().toString();
            }
            return JSONValue(uuids);
        }
    );

    server.start();
}
