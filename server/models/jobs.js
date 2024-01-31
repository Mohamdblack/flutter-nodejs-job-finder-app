const mongoose = require("mongoose");
const UserModel = require("./user");

const jobSchema = new mongoose.Schema({

    companyName : {
        type:String,
        required:true,
    },
    jobName : {
        type:String,
        required:true,
    },
    jobSalary : {
        type:Number,
        default: "Full-Time",
        required:true
    },
    jobType : {
        type:String,
        default: "Full-Time"
    },
    workingModel : {
        type:String,
        default: "Remote"
    },
    jobLevel : {
        type:String,
        default: "Internship"
    },
    jobLocation : {
        type:String,
        default: "California, USA"
    },
    companyProfile : {
        type:String,
        default: "https://www.vectorico.com/wp-content/uploads/2018/02/Behance-Logo-600x458.png"
    },
    createdBy : {
        type:mongoose.Types.ObjectId,
        ref: UserModel.modelName
    },

},
{timestamps:true}
);

const jobModel = mongoose.model("jobs",jobSchema);
module.exports = jobModel;