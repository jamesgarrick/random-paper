import mainHTML from "./index.html";
import { serve } from "bun";

const { neon } = require("@neondatabase/serverless");

const sql = neon(process.env.DATABASE_URL);


console.log("Index.ts...")


serve({
  port: 3000,
  hostname: "0.0.0.0",
  routes: {
    "/": mainHTML,
    "/api/random": {
      GET: async req => {
        const rows = await sql`
        SELECT abstract, authors, title
        FROM arxiv_metadata
        ORDER BY RANDOM()
        LIMIT 1`;
        const abstract = rows[0].abstract || "";
        const authors = rows[0].authors || "";
        const title = rows[0].title || "";
        console.log(abstract, authors);



        return new Response(JSON.stringify({ abstract, authors, title }), {
          headers: { "Content-Type": "application/json" },
        });
      },
    },
  }
})