const UserModel = require("../models/user");
const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");


// * Register || Sign Up
module.exports.register = async(req,res)=>{

        const {companyName, email, password, location, role,profile} = req.body;

        try{

          const existingUser = await UserModel.findOne({ email });
          if(existingUser){
            return res.status(400).json({
                msg : "User with same email already exists!"
            })
          }  

          const hashedPassword = await bcrypt.hash(password,8);

          let user = new UserModel({
            companyName,
            email,
            password : hashedPassword,
            role, 
            location,
            profile
          })

          await user.save();
          
          res.status(200).json({
                msg: "User registered successfully!",
                data : user
            });




        }
        catch(error){
            console.error("Error during user registration:", error);
            res.status(500).json({
                error: "Internal server error"
            });
        }

}

// * Login || Sign In

module.exports.login = async(req,res)=>{
    const {email,password} = req.body;


    try{
    
        const user = await UserModel.findOne({ email });

        if(!user){
            return res.status(400).json({
                msg: "There is no user with this email"
            });
        }

        const isMatch = await bcrypt.compare(password,user.password);
        if(!isMatch){
            return res.status(400).json({
                msg: "incorrect password!"
            });
        }
        const token = jwt.sign(
            
            { id: user._id},
            "secretToken",
            { expiresIn: '7d' }
        );

        return res.status(200).json({
            msg: "Login successful!",
            token,
            ...user._doc
        });


    }
    catch(error){
        console.error("Error during user registration:", error);
        return res.status(500).json({
            error: "Internal server error"
        });
    }
    
}
// * Update User Info || Update

module.exports.updateUser = async(req,res)=>{


    try{
    
        const updatedUser = await UserModel.findByIdAndUpdate(
            req.params.id,
            {$set: req.body},
            {new: true}
            );
       
            const {__v,createdAt,updatedAt,...updatedUserInfo} = updatedUser._doc;

            res.json(updatedUserInfo);


    }
    catch(error){
        console.error("Error during user registration:", error);
        return res.status(500).json({
            error: "Internal server error"
        });
    }
    
}

module.exports.tokenIsValid = async(req,res)=>{
    
    try{
        
        const token = req.header('token');
        if(!token) return res.json(false);
        const verifiedToken = jwt.verify(token,'secretToken');
        if(!verifiedToken) return res.json(false);

        const user = await UserModel.findById(verifiedToken.id);
        if(!user) return res.json(false);

        res.json(true);


    }
    catch(error){
        console.error("Error during user registration:", error);
        return res.status(500).json({
            error: "Internal server error"
        });
    }
    
}

// * Get User data
module.exports.getUserData = async(req,res)=>{
    
    try{
        
        const user = await UserModel.findById(req.user);
        res.json({
            ...user._doc,
            token: req.token
        })

    }
    catch(error){
        console.error("Error during user registration:", error);
        return res.status(500).json({
            error: "Internal server error"
        });
    }
    
}