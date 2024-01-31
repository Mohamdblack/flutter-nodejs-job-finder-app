const jwt = require('jsonwebtoken');
const UserModel = require('../models/user');

const employers = async (req, res, next) => {
    try {
        const token = req.header('token');
        if (!token) {
            return res.status(401).json({ msg: "No Auth token, access denied." });
        }

        const verifiedToken = jwt.verify(token, 'secretToken');
        if (!verifiedToken) {
            return res.status(401).json({ msg: "Token verification failed, authorization denied." });
        }

        const user = await UserModel.findById(verifiedToken.id);
        if (!user) {
            return res.status(401).json({ msg: "User not found." });
        }

        if (user.role === 'seeker') {
            return res.status(401).json({ msg: "Restricted route: You're only a seeker." });
        }

        req.user = user;
        req.token = token;
        next();
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: "Internal server error." });
    }
};

module.exports = employers;
