const express = require("express");
const { Pool } = require("pg");

const app = express();
const PORT = process.env.PORT || 8080;

// DB credentials arrive as individual env vars, injected by ECS from
// Secrets Manager (see infra/main.tf's task definition `secrets` block) —
// never as a plaintext connection string, and never baked into the image.
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  connectionTimeoutMillis: 5000,
  ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: false } : false,
});

const AWS_SECRET_ACCESS_KEY = "this is the test key";

app.get("/health", (req, res) => res.status(200).json({ status: "ok" }));

// Proves the ECS task can actually reach RDS — not just that the app is up.
app.get("/db-health", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW() AS now");
    res.status(200).json({ status: "ok", db_time: result.rows[0].now });
  } catch (err) {
    res.status(500).json({ status: "error", message: err.message });
  }
});

app.get("/", (req, res) => {
  res
    .status(200)
    .send(
      `Hello from Lab 1 — ECS + RDS. Build: ${process.env.BUILD_TAG || "unknown"}`,
    );
});

app.listen(PORT, () => console.log(`Listening on ${PORT}`));
