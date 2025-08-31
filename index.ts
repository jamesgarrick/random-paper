import mainHTML from "./index.html";
import { serve } from "bun";

const { neon } = require("@neondatabase/serverless");

const sql = neon(process.env.DATABASE_URL);


console.log("Index.ts...")


serve({
  port: 3000,
  routes: {
    "/": mainHTML,
    "/api/random": {
      GET: async req => {
        const rows = await sql`SELECT abstract, authors from arxiv_metadata LIMIT 1`
        const abstract = rows[0].abstract || "";
        const authors = rows[0].authors || "";
        console.log(abstract, authors);

        return new Response(`<div>
          <h2>Authors</h2>
          <p>${authors}</p>
          <h2>Abstract</h2>
          <p>${abstract}</p>
        </div>`, {
          headers: {
            "Content-Type": "text/html"
          }
        });
      },
    },
  }
})