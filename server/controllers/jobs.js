const UserModel = require("../models/user");
const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");
const jobModel = require("../models/jobs");


// * Create job || POST
module.exports.createJob = async(req,res)=>{

        const {companyName, jobName, jobSalary,jobType,workingModel,jobLevel,jobLocation,companyProfile,createdBy} = req.body;

        try{
            const jobs = new jobModel({
                companyName,
                jobName,
                jobSalary,
                jobType,
                workingModel,
                jobLevel,
                jobLocation,
                companyProfile,
                createdBy
            })
        
            await jobs.save();
            res.json({
                msg : "job created successfuly..",
                jobs : jobs
            })
           
        }
        catch(error){
            console.error("Error during user registration:", error);
            res.status(500).json({
                error: "Internal server error"
            });
        }

}
// * Update job || Patch
module.exports.updateJob = async(req,res)=>{


        try{
           
            const updatedJob = await jobModel.findByIdAndUpdate(
                req.params.id,
                {$set: req.body},
                {new: true}
                );
           
                const {__v,createdAt,updatedAt,...updatedJobInfo} = updatedJob._doc;

                res.json(updatedJobInfo);
        }
        catch(error){
            console.error("Error during user registration:", error);
            res.status(500).json({
                error: "Internal server error"
            });
        }

}
// * Delete job || Delete
module.exports.deleteJob = async(req,res)=>{


        try{
           
            
           const {id} = req.params;

           const deletedJob = await jobModel.findByIdAndDelete(id)

           if(!deletedJob){
            return res.status(404).json({
                error: "Job not found"
            })
        }

        res.json({
            msg: `Job with this name ${deletedJob.jobName} deleted successfuly.`
        })
        }
        catch(error){
            console.error("Error during user registration:", error);
            res.status(500).json({
                error: "Internal server error"
            });
        }

}

// * Get All jobs || Get
module.exports.getAllJobs = async(req,res)=>{


        try{

            const jobs = await jobModel.find({}).sort({ createdAt: -1 });

                

            res.json(
                jobs
            )
           
        }
        catch(error){
            console.error("Error during user registration:", error);
            res.status(500).json({
                error: "Internal server error"
            });
        }

}
// * Get My Own jobs || Get
module.exports.getMyJobs = async (req, res) => {
    try {
        
        const userJobs = await jobModel.find({ createdBy: req.user });
        res.json(userJobs);
    } catch (error) {
        console.error("Error while fetching user jobs:", error);
        res.status(500).json({ error: "Internal server error" });
    }
};



// * Search jobs || Get
module.exports.searchJob = async(req,res)=>{


        try{

            const jobs = await jobModel.find({
                jobName: { $regex: req.params.name, $options: "i"},
            });

            
            
           res.json(jobs);
        }
        catch(error){
            console.error("Error during user registration:", error);
            res.status(500).json({
                error: "Internal server error"
            });
        }

}
