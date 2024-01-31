const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({

    companyName : {
        type:String,
        required:true,
    },
    email : {
        type:String,
        required:true,
        unique:true,
        trim:true
    },
    location : {
        type:String,
        default:"somalia"
    },
    password : {
        type:String,
        required:true
    },
    role : {
        type:String,
        default:"seeker"
    },
    profile : {
        type:String,
        default:"https://www.vectorico.com/wp-content/uploads/2018/02/Behance-Logo-600x458.png"
    },


})

const UserModel = mongoose.model("users",userSchema);
module.exports = UserModel;