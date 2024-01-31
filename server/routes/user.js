const express = require("express");
const { register, login, tokenIsValid, getUserData, updateUser } = require("../controllers/user");
const auth = require("../middlewares/user_auth");
const AuthRouter = express.Router();

// * <=================> Register User || post <=================>
AuthRouter.post("/register",register);

// * <=================> Logging User || post <=================>
AuthRouter.post("/login",login);

// * <=================> Validate Token || post <=================>
AuthRouter.post("/tokenIsValid",tokenIsValid);


// * <=================> Get User Data || Get <=================>
AuthRouter.get("/",auth,getUserData);

// * <=================> Update User info || Patch <=================>
AuthRouter.patch('/:id',auth,updateUser);

module.exports = AuthRouter;