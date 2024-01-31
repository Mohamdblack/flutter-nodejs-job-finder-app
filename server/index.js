const express = require("express");
const AuthRouter = require("./routes/user");
const mongoose = require("mongoose");
const JobRouter = require("./routes/jobs");

const app = express();
const PORT = 8000;

app.use(express.json());

app.use("/auth",AuthRouter);
app.use("/job",JobRouter);

// & connection DB
mongoose.connect("mongodb://127.0.0.1:27017/shaqoPlus")
        .then(()=>{
            console.log("Connection successful...");
        })
        .catch(()=>{
            console.log("Connection failded...");

        })

app.listen(PORT,()=>{
    console.log(`Server is listening on port ${PORT}`);
});