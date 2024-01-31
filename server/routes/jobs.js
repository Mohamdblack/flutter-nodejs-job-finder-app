const express = require("express");
const { createJob, getAllJobs, updateJob, searchJob, getMyJobs, deleteJob } = require("../controllers/jobs");
const auth = require("../middlewares/user_auth");
const employers = require("../middlewares/employers");
const JobRouter = express.Router();


// * <=================> create job || post <=================>
JobRouter.post("/create-job",employers,createJob);


// * <=================> update job || Patch <=================>
JobRouter.patch("/:id",employers,updateJob);

// * <=================> Delete job || Delete <=================>
JobRouter.delete("/:id",employers,deleteJob);


// * <=================> get Alljobs || Get <=================>
JobRouter.get("/",getAllJobs);


// * <=================> get All My Own jobs || Get <=================>
JobRouter.get("/own-jobs",auth,getMyJobs);


// * <=================> Search Job || Get <=================>
JobRouter.get("/search/:name",searchJob);



module.exports = JobRouter;