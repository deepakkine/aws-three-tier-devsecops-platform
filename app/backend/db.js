const mongoose = require("mongoose");

async function connectWithRetry() {
    const connectionParams = {};

    if (process.env.USE_DB_AUTH === "true") {
        connectionParams.user = process.env.MONGO_USERNAME;
        connectionParams.pass = process.env.MONGO_PASSWORD;
    }

    while (true) {
        try {
            await mongoose.connect(
                process.env.MONGO_CONN_STR,
                connectionParams
            );

            console.log("✅ Connected to MongoDB");
            break;

        } catch (err) {
            console.error("❌ MongoDB unavailable. Retrying in 5 seconds...");
            console.error(err.message);

            await new Promise(resolve => setTimeout(resolve, 5000));
        }
    }
}

module.exports = connectWithRetry;