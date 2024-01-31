const jwt = require('jsonwebtoken');

const auth = async (req,res,next)=>{

    try{
        const token = req.header('token');
        if(!token){
            return res.status(401).json({msg:"No Auth token, access denied."})
        }
        const verifiedToken = jwt.verify(token,'secretToken');
        if(!verifiedToken){
            return res.status(401).json({msg:"token verification failed, authorization denied."})

        }
        
        // ? Current Logged User
        req.user = verifiedToken.id;
        req.token = token;
        next(); 


    }catch(e){
        res.status(500).json({error:e.message})
    }

}

module.exports = auth;