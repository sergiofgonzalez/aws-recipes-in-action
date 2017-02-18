"use strict";

const util = require("util");

const log4js = require("log4js");
const AWS = require("aws-sdk");

const config = require("./lib/config");

// Logger configuration
const logger = log4js.getLogger("index.js");
logger.setLevel(config("LOGGER:LEVEL"));

util.inspect.defaultOptions.depth = null;


const credentials = new AWS.SharedIniFileCredentials({profile: config("AWS:PROFILE")});
AWS.config.credentials = credentials;

const ec2 = new AWS.EC2({region: config("AWS:REGION")});

const instanceId = "i-0e8d93996e2358963";

ec2.describeInstances({
  InstanceIds: [instanceId]
}, (err, data) => {
  if (err) {
    logger.error(`Could not retrieve instance information for ${instanceId}: ${err}`);
    throw new Error(err);
  }
  logger.debug(`Instance info=${util.inspect(data)}`);
});