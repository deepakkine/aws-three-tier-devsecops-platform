const tasks = require("./routes/tasks");
const connection = require("./db");
const cors = require("cors");
const express = require("express");
const mongoose = require("mongoose");

const app = express();

app.use(express.json());
app.use(cors());

/**
 * Health Check
 * Returns 200 if application is running.
 */
app.get("/healthz", (req, res) => {
    res.status(200).send("Healthy");
});

/**
 * Startup Probe
 * Returns 200 once the application has started.
 */
app.get("/started", (req, res) => {
    res.status(200).send("Started");
});

/**
 * Readiness Probe
 * Returns 200 only when MongoDB connection is established.
 */
app.get("/ready", (req, res) => {
    if (mongoose.connection.readyState === 1) {
        return res.status(200).send("Ready");
    }

    return res.status(503).send("Not Ready");
});

app.use("/api/tasks", tasks);

const PORT = process.env.PORT || 3500;

async function startServer() {
    try {
        console.log("Connecting to MongoDB...");

        await connection();

        app.listen(PORT, () => {
            console.log(`🚀 Backend started on port ${PORT}`);
        });

    } catch (err) {
        console.error(err);
        process.exit(1);
    }
}

startServer();